import org.jetbrains.kotlin.gradle.plugin.mpp.apple.XCFramework

plugins {
    kotlin("multiplatform").version("1.7.20")
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

    jvm()

    sourceSets {
        val commonMain by getting
        val commonTest by getting
    }
}

tasks.create<Delete>("cleanIOSFramework") {
    dependsOn(":assembleMobileCommonXCFramework")
    delete(layout.projectDirectory.dir("MobileCommon.xcframework"))
}

tasks.create<Copy>("moveIOSFramework") {
    dependsOn(":cleanIOSFramework")
    from(layout.buildDirectory.file("XCFrameworks/release"))
    into(layout.projectDirectory)
}
