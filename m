Return-Path: <linux-pwm+bounces-451-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4E7809FB0
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 10:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E602816C4
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 09:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB9112B8E;
	Fri,  8 Dec 2023 09:42:24 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0D11718;
	Fri,  8 Dec 2023 01:42:16 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id C58F58246;
	Fri,  8 Dec 2023 17:42:14 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 8 Dec
 2023 17:42:14 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX068.cuchost.com (172.16.6.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 8 Dec 2023 17:42:13 +0800
From: William Qiu <william.qiu@starfivetech.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-pwm@vger.kernel.org>
CC: Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "Hal
 Feng" <hal.feng@starfivetech.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v9 4/4] riscv: dts: starfive: jh7110: Add PWM node and pins configuration
Date: Fri, 8 Dec 2023 17:42:09 +0800
Message-ID: <20231208094209.1910934-5-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208094209.1910934-1-william.qiu@starfivetech.com>
References: <20231208094209.1910934-1-william.qiu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

Add OpenCores PWM controller node and add PWM pins configuration
on VisionFive 2 board.

Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 .../jh7110-starfive-visionfive-2.dtsi         | 22 +++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  9 ++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dt=
si b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index b89e9791efa7..e08af8a830ab 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -323,6 +323,12 @@ reserved-data@600000 {
 	};
 };
=20
+&pwm {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pwm_pins>;
+	status =3D "okay";
+};
+
 &spi0 {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&spi0_pins>;
@@ -513,6 +519,22 @@ GPOEN_ENABLE,
 		};
 	};
=20
+	pwm_pins: pwm-0 {
+		pwm-pins {
+			pinmux =3D <GPIOMUX(46, GPOUT_SYS_PWM_CHANNEL0,
+					      GPOEN_SYS_PWM0_CHANNEL0,
+					      GPI_NONE)>,
+				 <GPIOMUX(59, GPOUT_SYS_PWM_CHANNEL1,
+					      GPOEN_SYS_PWM0_CHANNEL1,
+					      GPI_NONE)>;
+			bias-disable;
+			drive-strength =3D <12>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate =3D <0>;
+		};
+	};
+
 	spi0_pins: spi0-0 {
 		mosi-pins {
 			pinmux =3D <GPIOMUX(52, GPOUT_SYS_SPI0_TXD,
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/d=
ts/starfive/jh7110.dtsi
index 45213cdf50dc..1b782f2c1395 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -829,6 +829,15 @@ i2stx1: i2s@120c0000 {
 			status =3D "disabled";
 		};
=20
+		pwm: pwm@120d0000 {
+			compatible =3D "starfive,jh7110-pwm", "opencores,pwm-v1";
+			reg =3D <0x0 0x120d0000 0x0 0x10000>;
+			clocks =3D <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets =3D <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells =3D <3>;
+			status =3D "disabled";
+		};
+
 		sfctemp: temperature-sensor@120e0000 {
 			compatible =3D "starfive,jh7110-temp";
 			reg =3D <0x0 0x120e0000 0x0 0x10000>;
--=20
2.34.1


