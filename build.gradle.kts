import org.jetbrains.kotlin.gradle.plugin.mpp.apple.XCFramework

plugins {
    kotlin("multiplatform").version("1.7.20")
    id("maven-publish")
    id("com.apollographql.apollo3").version("3.7.0")
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

    jvm()

    sourceSets {
        val commonMain by getting {
            dependencies {
                implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.6.4")
                implementation("com.apollographql.apollo3:apollo-runtime:3.7.0")
            }
        }
        val commonTest by getting
    }
}

apollo {
    packageName.set("com.electra.mobile.network")
}

tasks.create<Zip>("zipIOSFramework") {
    dependsOn(":assembleMobileCommonXCFramework")
    from(layout.buildDirectory.dir("XCFrameworks/release"))
    include("MobileCommon.xcframework")
    include("MobileCommon.xcframework/**/*")
    archiveFileName.set("MobileCommon.zip")
    destinationDirectory.set(layout.buildDirectory.dir("XCFrameworks"))
}
