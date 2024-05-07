Return-Path: <linux-pwm+bounces-2163-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2998BDBEB
	for <lists+linux-pwm@lfdr.de>; Tue,  7 May 2024 08:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47A31F21B1F
	for <lists+linux-pwm@lfdr.de>; Tue,  7 May 2024 06:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052BC78C85;
	Tue,  7 May 2024 06:54:34 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4591978C74;
	Tue,  7 May 2024 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715064873; cv=none; b=RMGXmMFWSUqnyH7QOrugMi0HQHJAAjWRWUaI/C0LqqlJJugv4jI/Ju477crrindCjEX2+JNjL79K78A+NmT3OxrlybXxmd82O5MjdGrGfA+YF/iksFy7DSuLo2g8IJtn7YVrNCotw2jC9U9nzLyBIORrO42Wz94leEsFrCryMkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715064873; c=relaxed/simple;
	bh=WDprQ2ku0zWmgu0S5W5JI4xF1eo8CEHRVWVPF7RL56M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qQuU1hbFQD7A5eB50dFamzQ06qTO6JQFvGED1fGCp2PpU8HbQk31MCizHXXucd0UIgaiGHiOCozX83T1g9odfftT9CkJvI/WlCu0mwfYuA3ZmsQUl3mhJxTJ8XCWf/51SFUHz682UivN4TdK7+q+E26uCvgO2BquzRV4kbmJtQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8CxiOkj0Dlm67IIAA--.11260S3;
	Tue, 07 May 2024 14:54:27 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxvdwg0DlmFqsTAA--.39074S2;
	Tue, 07 May 2024 14:54:25 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	loongson-kernel@lists.loongnix.cn,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH] dt-bindings: pwm: renesas,tpu: Do not require pwm-cells twice
Date: Tue,  7 May 2024 14:54:12 +0800
Message-ID: <c0590d8898e553f29c96c7c4083f7b3ca1915727.1715050962.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cxvdwg0DlmFqsTAA--.39074S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUU9mb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21le4C262xC7I0v67AEwI8IwI
	1l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv2
	0xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7
	xvr2IYc2Ij64vIr41lw4CEx2IqxVAFz4v204v26I0v724l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUJVWUGwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j
	6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=

pwm-cells property is already required by pwm.yaml schema.

Suggested-by: Uwe Kleine-König <ukleinek@kernel.org>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---

This is a missing patch to cleanup the required pwm-cells attribute twice[1].
Thanks to Uwe for the heads up.
[1]:https://lore.kernel.org/linux-pwm/cover.1714450308.git.zhoubinbin@loongson.cn/ 

 Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
index a3e52b22dd18..4c8ce7a26d13 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
@@ -16,7 +16,6 @@ select:
         const: renesas,tpu
   required:
     - compatible
-    - '#pwm-cells'
 
 properties:
   compatible:
-- 
2.43.0


