Return-Path: <linux-pwm+bounces-4931-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8E3A37E7D
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Feb 2025 10:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 598267A4DE1
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Feb 2025 09:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31AD215766;
	Mon, 17 Feb 2025 09:30:49 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FF021518D;
	Mon, 17 Feb 2025 09:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739784649; cv=none; b=e96qRVapbNBFtK3qTzGHcgIXtrbIi3MMZXGs/0KF4igo8YcQd27AvehxVbmWWp/7BLijz1VC+bZwzPojhMWDhkh/I0MvCD5RmhrPuuceOQAewsopfaqcXtkpSqE1LSLbDi/hY3jBzG578AnQV27wQDsXTMmVrF756vZnXLCwQNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739784649; c=relaxed/simple;
	bh=ZjpSnWoRZEGLzQ0+51AM5+Vo9AxdrEHXR7jTBEicLlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YzBLUrnjySQqQURODQadT0a+5134RMIpj7rmzBrQsomLPSJdqvinF6t62JV9Ro650dJezYktUkYceV22aPjjWhkF1/NQDMaX6fh7biqF4UfIJjdWmwAmbYQUG6oUCmEx8MtcpDnrJ3DYKRznfxHgeJRS0tA5J9ro5SquybiBZpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.156])
	by gateway (Coremail) with SMTP id _____8AxaeC_AbNn+JZ4AA--.13441S3;
	Mon, 17 Feb 2025 17:30:39 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.156])
	by front1 (Coremail) with SMTP id qMiowMBxLse7AbNnvO4XAA--.26537S2;
	Mon, 17 Feb 2025 17:30:36 +0800 (CST)
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
Subject: [PATCH v9 0/2] pwm: Introduce pwm driver for the Loongson family chips
Date: Mon, 17 Feb 2025 17:30:23 +0800
Message-ID: <cover.1739784071.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxLse7AbNnvO4XAA--.26537S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUU9qb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487M2AExVAIFx02aVAFz4v204v7Mc
	804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY
	67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y4
	8IcxkI7VAKI48JM4kE6I8I3I0E14AKx2xKxVC2ax8xMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	0_Jr4lx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUUU

Hi all:

This patchset introduce a generic PWM framework driver for Loongson family.
Each PWM has one pulse width output signal and one pulse input signal to be measured.

It can be found on Loongson-2K series cpus and Loongson LS7A bridge chips.

Thanks.

-------
V9:
patch (2/2):
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

 .../bindings/pwm/loongson,ls7a-pwm.yaml       |  66 +++++
 MAINTAINERS                                   |   7 +
 drivers/pwm/Kconfig                           |  12 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-loongson.c                    | 278 ++++++++++++++++++
 5 files changed, 364 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/loongson,ls7a-pwm.yaml
 create mode 100644 drivers/pwm/pwm-loongson.c


base-commit: e8af7c083520a7b9b027b2bb282464013a96047d
-- 
2.47.1


