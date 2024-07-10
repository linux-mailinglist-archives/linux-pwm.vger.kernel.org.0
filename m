Return-Path: <linux-pwm+bounces-2744-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7080C92C840
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jul 2024 04:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6E58B2171F
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jul 2024 02:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B8BB647;
	Wed, 10 Jul 2024 02:04:34 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7579379F9;
	Wed, 10 Jul 2024 02:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720577074; cv=none; b=M9nPMG4qPa9uJG8iCFpmy4YLVv73eYr5snuJpr7UVRP0nMCsaIqT7eejAO/bTqCUWzvQU7xlAVLTt7LkxcRqJMVuRACNR8cad22hMZsnBNl/vqRhYCVeYsriPF7811dza48crLlfLHoC/sokp/skAI5dMHaRxnJKuyntZPxv8z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720577074; c=relaxed/simple;
	bh=OF4iBGvb9X3tMuyvQvdFjy8gf8wmnSu8oFLGlbNxt7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W3fJoD4rTq5BrprDkUMKcn+5xOIWnr4x8MlnmpgcDgQlYoJKYpPhlHftA4vYbkpOEcbQgAv+d+UWL4tmfOLYhhxOQIwPIjlkXPeTu7Kgv6uYqvRgFY/FmKSIvg7wa0DzTG5+lH2rDncKHuCow8fGBLcElfywc250OrsWMvUrL4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.130])
	by gateway (Coremail) with SMTP id _____8DxS_Al7I1mP6wCAA--.8015S3;
	Wed, 10 Jul 2024 10:04:21 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.130])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxbccj7I1m3OFBAA--.20688S2;
	Wed, 10 Jul 2024 10:04:20 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Juxin Gao <gaojuxin@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v5 0/2] pwm: Introduce pwm driver for the Loongson family chips
Date: Wed, 10 Jul 2024 10:04:05 +0800
Message-ID: <cover.1720516327.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cxbccj7I1m3OFBAA--.20688S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uryfGF48GFW8uryDZFW3twc_yoW8tw48pF
	Z8Cw13Kr18tr12krs3Ja48CF1SvayrJFZrGFsav348Wa98Ca4jv3yfKa15ArZrCr12vFW2
	vrZ3CFWjka45uFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07URa0PUUUUU=

Hi all:

This patchset introduce a generic PWM framework driver for Loongson family.
Each PWM has one pulse width output signal and one pulse input signal to be measured.

It can be found on Loongson-2K series cpus and Loongson LS7A bridge chips.

Thanks.

-------
V5:
patch (2/2):
 - Rebase on pwm/for-next;
 - Test with PWM_DEBUG enabled;
 - Rewrote pwm_loongson_apply() and adjusted the order of pwm status and
   polarity to avoid test failure;
 - Added DIV64_U64_ROUND_UP in pwm_loongson_get_state() to avoid
   precision loss and to avoid test failures.

Link to V4:
https://lore.kernel.org/all/cover.1716795485.git.zhoubinbin@loongson.cn/

V4:
patch (2/2):
 - Rebase on pwm/for-next;
 - Addressed Uwe's review comments:
   - Make use of devm_pwmchip_alloc() function;
   - Add Limitations description;
   - Add LOONGSON_ prefix for Loongson pwm register defines;
   - Keep regs written only once;
   - Rewrite duty/period calculation;
   - Add dev_err_probe() in .probe();
   - Fix some code style.

Link to V3:
https://lore.kernel.org/linux-pwm/cover.1713164810.git.zhoubinbin@loongson.cn/

V3:
patch (1/2):
 - Add Reviewed-by tag from Krzysztof, thanks.
patch (2/2):
 - Several code stlye adjustments, such as line breaks.

Link to V2:
https://lore.kernel.org/all/cover.1712732719.git.zhoubinbin@loongson.cn/

v2:
- Remove the dts-related patches and update dts at once after all
relevant drivers are complete.
patch (1/2):
 - The dt-binding filename should match compatible, rename it as
   loongson,ls7a-pwm.yaml;
 - Update binding description;
 - Add description for each pwm cell;
 - Drop '#pwm-cells' from required, for pwm.yaml makes it required already.

Link to v1:
https://lore.kernel.org/linux-pwm/cover.1711953223.git.zhoubinbin@loongson.cn/

Binbin Zhou (2):
  dt-bindings: pwm: Add Loongson PWM controller
  pwm: Add Loongson PWM controller support

 .../bindings/pwm/loongson,ls7a-pwm.yaml       |  66 ++++
 MAINTAINERS                                   |   7 +
 drivers/pwm/Kconfig                           |  12 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-loongson.c                    | 285 ++++++++++++++++++
 5 files changed, 371 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/loongson,ls7a-pwm.yaml
 create mode 100644 drivers/pwm/pwm-loongson.c

-- 
2.43.5


