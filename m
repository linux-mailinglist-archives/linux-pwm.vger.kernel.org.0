Return-Path: <linux-pwm+bounces-1845-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E222894D0E
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Apr 2024 09:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17801F227AE
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Apr 2024 07:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B40F3D39B;
	Tue,  2 Apr 2024 07:59:08 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A732BD1C;
	Tue,  2 Apr 2024 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712044748; cv=none; b=hlkDZiDIdOL0SDpNN95CLPJWACMAeCh5SiedA7SmJDXs2SHn9pZHaA6e23v/XkM8ADe6op2hDRGmrPP4SE1G2DfJLCJR3xQK1h+SnRYQO4tpwkVdNU+jL9W9/Iceq6/PXjUPUzGVsyodmT7xmxPOtjYON0Vfj+blz4nA6r+3TlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712044748; c=relaxed/simple;
	bh=UgmIAAI93EZJTtg+aK3e6ZZ+M8Jue3lfJ/8p2/tBVqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3S50MYBiLjgVwE5M3AAgmCJ2ERHdcv8dseL06cp3rLitjScvRT3rxbf2+Se7gQXyUL8UtPQxGpEAh5MU0SM+QgmXaJt3PjJJ1106wxqs3MakQ+CBBYwkNNpVbLcLMLKUFvxmZ2eEr3WPOls/1I1w0B0igqbFrJHUrb2GcbsIR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.80])
	by gateway (Coremail) with SMTP id _____8Dx_7vHugtmeD8iAA--.59479S3;
	Tue, 02 Apr 2024 15:59:03 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.80])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxSRK7ugtmzqNxAA--.12573S5;
	Tue, 02 Apr 2024 15:59:01 +0800 (CST)
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
Subject: [PATCH v1 3/5] LoongArch: dts: Add PWM support to Loongson-2K0500
Date: Tue,  2 Apr 2024 15:58:40 +0800
Message-ID: <b1c34d8b86efe99c4eaa428e5130e9aecd01eb52.1711953223.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:AQAAf8AxSRK7ugtmzqNxAA--.12573S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Jr4fWr4rXF48Jry7Kw18CrX_yoW8Jr4xpa
	sF939xGr40gF1xKws8JFy8Krs3uFyFkFnrWanrAFyUGrsIq3yjvr18JFyfXF4rWrs5X342
	qrn5C347KFWUWabCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jr6p9UUUUU=

The module is supported, enable it.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 arch/loongarch/boot/dts/loongson-2k0500.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/loongarch/boot/dts/loongson-2k0500.dtsi b/arch/loongarch/boot/dts/loongson-2k0500.dtsi
index 413b83366367..86e86a267779 100644
--- a/arch/loongarch/boot/dts/loongson-2k0500.dtsi
+++ b/arch/loongarch/boot/dts/loongson-2k0500.dtsi
@@ -148,6 +148,26 @@ eiointc: interrupt-controller@1fe11600 {
 			interrupts = <3>;
 		};
 
+		pwm@1ff5c000 {
+			compatible = "loongson,ls2k0500-pwm", "loongson,ls7a-pwm";
+			reg = <0x0 0x1ff5c000 0x0 0x10>;
+			interrupt-parent = <&eiointc>;
+			interrupts = <20>;
+			clocks = <&clk LOONGSON2_APB_CLK>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm@1ff5c010 {
+			compatible = "loongson,ls2k0500-pwm", "loongson,ls7a-pwm";
+			reg = <0x0 0x1ff5c010 0x0 0x10>;
+			interrupt-parent = <&eiointc>;
+			interrupts = <21>;
+			clocks = <&clk LOONGSON2_APB_CLK>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		gmac0: ethernet@1f020000 {
 			compatible = "snps,dwmac-3.70a";
 			reg = <0x0 0x1f020000 0x0 0x10000>;
-- 
2.43.0


