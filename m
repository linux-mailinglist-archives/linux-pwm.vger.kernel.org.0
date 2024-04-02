Return-Path: <linux-pwm+bounces-1848-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B17894D14
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Apr 2024 09:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730BC1F22774
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Apr 2024 07:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E711B3D547;
	Tue,  2 Apr 2024 07:59:26 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29C63D3A7;
	Tue,  2 Apr 2024 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712044766; cv=none; b=FZuMQAbeSSjAfqT6T8xWQyVlAoEngD9OulK1LHkXsShluJ6DvBEGFP3iwif1y8E1Qt1X5umquSUwl55SpkS359sPCO0KR5motolDm8NFs6WIcnYDRgZoBZsUU4JOvDPefequV6jVZUX/rRThFOb7i9JISQcK5lGOo7zbn0VkTC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712044766; c=relaxed/simple;
	bh=RjzY/TrHpPzgQXWVOSSQ3iE3+KepvtFf5tjgeWxzioU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVCOIkwGESXL67vfDmCjN6+Z7vvJ2whQTZjzpfJxaiauzSII9pYmvc+ASXyRx6+o9ww9CB+ClDES+fsRKghra/xLDPs+Q8UtgCIL6P9084MM6LDwpu5m0CsLVIgblPOlniuWDmzVcFrHlBw0dZ7gCGLbWjnqJ3nNs3FKDjFHyDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.80])
	by gateway (Coremail) with SMTP id _____8Axz+vaugtmuD8iAA--.13151S3;
	Tue, 02 Apr 2024 15:59:22 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.80])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxPs_WugtmEaRxAA--.22839S3;
	Tue, 02 Apr 2024 15:59:21 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	loongson-kernel@lists.loongnix.cn,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v1 5/5] LoongArch: dts: Add PWM support to Loongson-2K2000
Date: Tue,  2 Apr 2024 15:59:06 +0800
Message-ID: <7214b933ce85f9d030828e9efab7fbeb57eb712b.1711953223.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711953223.git.zhoubinbin@loongson.cn>
References: <cover.1711953223.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxPs_WugtmEaRxAA--.22839S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7AFW8ZFyxAFW8CFWxAF1UArc_yoW8Kw48pa
	sru3yUKrW0gF1Ikwn8XFy8KFZ3Zr95CF9rWFnrAFyUJ34DKw4jva18GFyxXF1xWr4UX34a
	vFnakryjgFZrXwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUVWrXDUUUU

The module is supported, enable it.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 arch/loongarch/boot/dts/loongson-2k2000.dtsi | 60 ++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/loongarch/boot/dts/loongson-2k2000.dtsi b/arch/loongarch/boot/dts/loongson-2k2000.dtsi
index 605efaba7292..278cbc27d19b 100644
--- a/arch/loongarch/boot/dts/loongson-2k2000.dtsi
+++ b/arch/loongarch/boot/dts/loongson-2k2000.dtsi
@@ -126,6 +126,66 @@ msi: msi-controller@1fe01140 {
 			interrupt-parent = <&eiointc>;
 		};
 
+		pwm@100a0000 {
+			compatible = "loongson,ls2k2000-pwm", "loongson,ls7a-pwm";
+			reg = <0x0 0x100a0000 0x0 0x10>;
+			interrupt-parent = <&pic>;
+			interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk LOONGSON2_MISC_CLK>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm@100a0100 {
+			compatible = "loongson,ls2k2000-pwm", "loongson,ls7a-pwm";
+			reg = <0x0 0x100a0100 0x0 0x10>;
+			interrupt-parent = <&pic>;
+			interrupts = <25 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk LOONGSON2_MISC_CLK>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm@100a0200 {
+			compatible = "loongson,ls2k2000-pwm", "loongson,ls7a-pwm";
+			reg = <0x0 0x100a0200 0x0 0x10>;
+			interrupt-parent = <&pic>;
+			interrupts = <26 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk LOONGSON2_MISC_CLK>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm@100a0300 {
+			compatible = "loongson,ls2k2000-pwm", "loongson,ls7a-pwm";
+			reg = <0x0 0x100a0300 0x0 0x10>;
+			interrupt-parent = <&pic>;
+			interrupts = <27 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk LOONGSON2_MISC_CLK>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm@100a0400 {
+			compatible = "loongson,ls2k2000-pwm", "loongson,ls7a-pwm";
+			reg = <0x0 0x100a0400 0x0 0x10>;
+			interrupt-parent = <&pic>;
+			interrupts = <38 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk LOONGSON2_MISC_CLK>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm@100a0500 {
+			compatible = "loongson,ls2k2000-pwm", "loongson,ls7a-pwm";
+			reg = <0x0 0x100a0500 0x0 0x10>;
+			interrupt-parent = <&pic>;
+			interrupts = <39 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk LOONGSON2_MISC_CLK>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		rtc0: rtc@100d0100 {
 			compatible = "loongson,ls2k2000-rtc", "loongson,ls7a-rtc";
 			reg = <0x0 0x100d0100 0x0 0x100>;
-- 
2.43.0


