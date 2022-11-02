import org.jetbrains.kotlin.gradle.plugin.mpp.apple.XCFramework

plugins {
    kotlin("multiplatform").version("1.7.20")
    id("com.android.library").version("7.2.0")
    id("maven-publish")
}

repositories {
    mavenCentral()
    google()
    jcenter()
}

group = "com.github.tritus"
val iOSLibName = "MobileCommon"

kotlin {
    // We don't build for iOS in case we are not on Mac OS
    if (System.getProperty("os.name") == "Mac OS X") {
        val xcFramework = XCFramework(iOSLibName)
        ios {
            binaries {
                framework(iOSLibName) {
                    xcFramework.add(this)
                }
            }
        }
        iosSimulatorArm64 {
            binaries {
                framework(iOSLibName) {
                    xcFramework.add(this)
                }
            }
        }
    }

    android()

    sourceSets {
        val commonMain by getting
        val commonTest by getting {
            dependencies {
                implementation(kotlin("test"))
            }
        }
        val androidMain by getting
        val androidTest by getting

        if (System.getProperty("os.name") == "Mac OS X") {
            val iosMain by getting
            val iosTest by getting
            val iosSimulatorArm64Main by getting
            val iosSimulatorArm64Test by getting


            // Set up dependencies between the source sets
            iosSimulatorArm64Main.dependsOn(iosMain)
            iosSimulatorArm64Test.dependsOn(iosTest)
        }
    }
}

android {
    compileSdk = 32
    sourceSets["main"].manifest.srcFile("src/androidMain/AndroidManifest.xml")
    defaultConfig {
        minSdk = 21
        targetSdk = 32
    }
}

tasks.create("publishLibs") {
    dependsOn(":assemble${iOSLibName}XCFramework")
    dependsOn(":publishKotlinMultiplatformPublicationToMavenRepository")
}

publishing {
    publications {
        named<MavenPublication>("kotlinMultiplatform") {
            artifactId = "mobile_common"
        }
    }
    repositories {
        maven {
            url = uri(rootDir.absolutePath + "/mavenRepo")
        }
    }
}