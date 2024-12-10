Return-Path: <linux-pwm+bounces-4297-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EE59EB0EA
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Dec 2024 13:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E461692EA
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Dec 2024 12:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1BF1A3A80;
	Tue, 10 Dec 2024 12:37:34 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB86B23DE98;
	Tue, 10 Dec 2024 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733834254; cv=none; b=Z/S5eDTnQm7vZrqf60RDFajq2Qk1ZJc1cacJG5oYFfIf7jX/clG9nwkMMuer31GbhZX42TducKwH1F95EP/+1ZmlCcC00uQMuQNg24dMYF4iXPRPV870WYoXXv/jGMsENPiU8YVQ373sTsUfvwn5ChrMtLx64SjRewMrlhLvpCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733834254; c=relaxed/simple;
	bh=r35ib2yZcI898iLxRlmgcgRipcJBXLk0bYxFgs8oIP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lKdCW/rFZhTUvWiO9VkZAB8VyRpdWqS3rpdCHhEssTwYyZSiUMcB0nz9mDY/w2wG6XZlbomnDZzrwc1vF1KlNOEdE16OURELGkb2hfLmVc4mMrlT3vNcsC1IPM2w/OKGJCKqqlCujSQoOsgIBkqsgrLLTBFGjHJJ4HjHFksMnPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.38])
	by gateway (Coremail) with SMTP id _____8DxGeAINlhnzuVUAA--.33361S3;
	Tue, 10 Dec 2024 20:37:28 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.38])
	by front1 (Coremail) with SMTP id qMiowMAxXcIENlhn9Sx+AA--.34092S2;
	Tue, 10 Dec 2024 20:37:26 +0800 (CST)
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
Subject: [PATCH v8 0/2] pwm: Introduce pwm driver for the Loongson family chips
Date: Tue, 10 Dec 2024 20:37:04 +0800
Message-ID: <cover.1733823417.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=a
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxXcIENlhn9Sx+AA--.34092S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUU9mb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21le4C262xC7I0v67AEwI8IwI
	1l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv2
	0xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7
	xvr2IYc2Ij64vIr41lw4CEx2IqxVAFz4v204v26I0v724l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUJVWUGwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j
	6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=

Hi all:

This patchset introduce a generic PWM framework driver for Loongson family.
Each PWM has one pulse width output signal and one pulse input signal to be measured.

It can be found on Loongson-2K series cpus and Loongson LS7A bridge chips.

Thanks.

-------
V8:
patch (2/2):
 - Rebase on pwm/for-next;
 - Drop inappropriate comments in “Limitations”;
 - Drop HZ_PER_KHZ for readability;
 - NANOHZ_PER_HZ -> NSEC_PER_SEC;
 - Rewrite the clk fetch section to look more flexible and not have to
   care about ACPI or DT;
 - Add explicit initialization of the CTRL register in probe().

Link to V7:
https://lore.kernel.org/all/cover.1729583747.git.zhoubinbin@loongson.cn/

V7:
Thanks for Sean's advice.
patch (2/2):
 - Set chip->atomic to keep pwm_apply_atomic() can be used with the pwm.
 - Test with CONFIG_PWM_DEBUG and CONFIG_DEBUG_ATOMIC_SLEEP enabled.

Link to V6:
https://lore.kernel.org/all/cover.1728463622.git.zhoubinbin@loongson.cn/

V6:
patch (2/2):
 - Rebase on pwm/for-next;
 - Add Reference Manual;
 - Shortcut if !pwm->state.enabled;
 - When state->enabled is true, unconditionally execute
   pwm_loongson_set_polarity() to avoid that the polarity register is
   not set correctly.

Link to V5:
https://lore.kernel.org/all/cover.1720516327.git.zhoubinbin@loongson.cn/

V5:
patch (2/2):
 - Rebase on pwm/for-next;
 - Test with PWM_DEBUG enabled.
 - In pwm_loongson_apply(), the pwm state is determined before the pwm
   polarity, avoid test failures when PWM_DEBUG is enabled;
 - Added DIV64_U64_ROUND_UP in pwm_loongson_get_state() to avoid
   precision loss and to avoid test failures when PWM_DEBUG is enabled.

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
 drivers/pwm/pwm-loongson.c                    | 296 ++++++++++++++++++
 5 files changed, 382 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/loongson,ls7a-pwm.yaml
 create mode 100644 drivers/pwm/pwm-loongson.c


base-commit: 483082d78a092a3c1f343a76a2edb196069b4092
-- 
2.43.5


