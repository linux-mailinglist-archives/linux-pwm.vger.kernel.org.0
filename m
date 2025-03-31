Return-Path: <linux-pwm+bounces-5306-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09302A75F12
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Mar 2025 08:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424951884467
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Mar 2025 06:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831F9198E76;
	Mon, 31 Mar 2025 06:54:10 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D8A16FF37;
	Mon, 31 Mar 2025 06:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743404050; cv=none; b=upCAUDYiL0dwOH89yCFHgoBUlXdodFnrtMYxmBFIZ9ROMrhS8YY0Gfq9ZlMOlyZoxXPQcMLm9wZz8ozsbMLpaN1cJyJxATpvfKWWOi5ibktiZsaGL+VcHQNc0dy6OBv1zI8DF/u0rVdZmXEc3VKbsYfWW5j+PbKgCoIVoI+gpc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743404050; c=relaxed/simple;
	bh=83xwarS4GyKOYWKeFmh1mXV82tPvIzMQuWi5zo8/xsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tmhxj7zVYqf2ThLBUyJKVnswrSCS6PhGAx7zEEWHnk1QDT+lkCfjln2N8YSiNYFA/MMvsprNJvvbDweAukp6oeUPLrTotepGbyAdCB7o8LmCpHte6Z157QmwUtbJD8kKJ7Pk00sxabzNdITu1wSOER1duqf2R+wSLhQtT9MH7ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.198])
	by gateway (Coremail) with SMTP id _____8AxaeEMPOpn0yisAA--.47071S3;
	Mon, 31 Mar 2025 14:54:04 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.198])
	by front1 (Coremail) with SMTP id qMiowMDxu8QJPOpnYuFoAA--.50182S2;
	Mon, 31 Mar 2025 14:54:02 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Juxin Gao <gaojuxin@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v10 0/2] pwm: Introduce pwm driver for the Loongson family chips
Date: Mon, 31 Mar 2025 14:53:48 +0800
Message-ID: <cover.1743403075.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=a
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxu8QJPOpnYuFoAA--.50182S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7Cj
	xVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487M2AExVAIFx02aVAFz4v204
	v7Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IY
	x2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4
	x0Y48IcxkI7VAKI48JM4kE6I8I3I0E14AKx2xKxVC2ax8xMxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_Jr0_Jr4lx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWU
	JVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUUU

Hi all:

This patchset introduce a generic PWM framework driver for Loongson family.
Each PWM has one pulse width output signal and one pulse input signal to be measured.

It can be found on Loongson-2K series cpus and Loongson LS7A bridge chips.

Thanks.

-------
V10:
patch (1/2):
 - Put my s-o-b tag last;
 - Add \n between the includes and the dt node.

patch (2/2):
 - Put my s-o-b tag last;
 - Add comment about the hardware complete the currently running period
   when changing settings or disabling;
 - Add _REG to the prefix of the register field definitions, such as
   LOONGSON_PWM_CTRL_EN -> LOONGSON_PWM_CTRL_REG_EN;
 - Mark to_pwm_loongson_ddata function as __pure;
 - Handling "ddata->clk_rate" assertions in probe;
 - To guarantee that mul_u64_u64_div_u64() results in a value that fits into an u32.

Link to V9:
https://lore.kernel.org/all/cover.1739784071.git.zhoubinbin@loongson.cn/

V9:
patch(2/2):
 - Add error message to devm_clk_rate_exclusive_get();
 - Make all errors start with a capital letter;
 - Drop explicit initialization of the CTRL register in probe();
 - Add pwm->state.enabled check in pwm_loongson_suspend();
 - Drop pwm_loongson_suspend_store{ }.

Link to V8:
https://lore.kernel.org/all/cover.1733823417.git.zhoubinbin@loongson.cn/

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

 .../bindings/pwm/loongson,ls7a-pwm.yaml       |  67 ++++
 MAINTAINERS                                   |   7 +
 drivers/pwm/Kconfig                           |  12 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-loongson.c                    | 290 ++++++++++++++++++
 5 files changed, 377 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/loongson,ls7a-pwm.yaml
 create mode 100644 drivers/pwm/pwm-loongson.c


base-commit: 6df320abbb40654085d7258de33d78481e93ac8d
-- 
2.47.1


