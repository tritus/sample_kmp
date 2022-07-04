import org.jetbrains.kotlin.gradle.plugin.mpp.apple.XCFramework

plugins {
    kotlin("multiplatform") version "1.7.0"
}

repositories {
    mavenCentral()
}

val iOSLibName = "MobileCommon"

kotlin {
    jvm {
        compilations.all {
            kotlinOptions.jvmTarget = "1.8"
        }
        withJava()
        testRuns["test"].executionTask.configure {
            useJUnitPlatform()
        }
    }
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

    sourceSets {
        val commonMain by getting
        val commonTest by getting {
            dependencies {
                implementation(kotlin("test"))
            }
        }
        val jvmMain by getting
        val jvmTest by getting
        val iosMain by getting
        val iosTest by getting
        val iosSimulatorArm64Main by getting
        val iosSimulatorArm64Test by getting

        // Set up dependencies between the source sets
        iosSimulatorArm64Main.dependsOn(iosMain)
        iosSimulatorArm64Test.dependsOn(iosTest)
    }
}
