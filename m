Return-Path: <linux-pwm+bounces-3744-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 553BD9A9DD6
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 11:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16569284374
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 09:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F29193427;
	Tue, 22 Oct 2024 09:04:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E31189BA6;
	Tue, 22 Oct 2024 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587868; cv=none; b=NJq75SCmMfb3VaH86PEGEnWwxYY/lbsVb4PLhLeGQC8G6hb+WjpEh3OkuJIrbH1nKNgUq9SKSK9JGjirk3Ohez4kg27bJYjJe8tlC3V05sOp44CPfm92LeCliUEGqhbRX592PCWeChbvsrZX1lIVdVUY3VQSPBUOhUXPnl0Kug8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587868; c=relaxed/simple;
	bh=FmDcReTPKUUV7YiJm+WOnQgrY+OEHQUfuIC7c1n0nYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JfAgOLHJokdIzme0MWxo99+iUT29Bm9vsx8OWP/nsPZ2CG1UONryJ+fqBkWpBHwgNp8MvgLsyBivVk807NktIW6wXTdsZJVNzgN9yju/PfSmBeGYSFB36EuE2YEWpX1ntVHqpDePBIhSHI/jLc9/kC/WBFlM6OmWv8dv+LKmwfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.52])
	by gateway (Coremail) with SMTP id _____8BxeeGVahdnsL4EAA--.10942S3;
	Tue, 22 Oct 2024 17:04:21 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.52])
	by front1 (Coremail) with SMTP id qMiowMAx7uCQahdnKy4HAA--.42603S2;
	Tue, 22 Oct 2024 17:04:17 +0800 (CST)
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
	Sean Young <sean@mess.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v7 0/2] pwm: Introduce pwm driver for the Loongson family chips
Date: Tue, 22 Oct 2024 17:04:13 +0800
Message-ID: <cover.1729583747.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAx7uCQahdnKy4HAA--.42603S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr48WF4DXw4DGF4kury7CFX_yoW5Cr47pF
	ZrC343Kr10qr10yrs3J348Cr1SvayrJF9rGFsay348X3yUCw4jqw4SgF45JFZrAr129F42
	vrZ3CFWjka4UuFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUc9a9UUUUU

Hi all:

This patchset introduce a generic PWM framework driver for Loongson family.
Each PWM has one pulse width output signal and one pulse input signal to be measured.

It can be found on Loongson-2K series cpus and Loongson LS7A bridge chips.

Thanks.

-------
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
 drivers/pwm/pwm-loongson.c                    | 288 ++++++++++++++++++
 5 files changed, 374 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/loongson,ls7a-pwm.yaml
 create mode 100644 drivers/pwm/pwm-loongson.c


base-commit: c13bce43b32b06f2273c7961940c391cdaf13d1e
-- 
2.43.5


