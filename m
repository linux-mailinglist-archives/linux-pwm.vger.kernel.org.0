Return-Path: <linux-pwm+bounces-2135-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F678B6BD7
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Apr 2024 09:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA771F225DD
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Apr 2024 07:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA653FB9B;
	Tue, 30 Apr 2024 07:32:35 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62993A1DE;
	Tue, 30 Apr 2024 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462355; cv=none; b=mvyrzMC2HFp24JQv0vkjL/WoobRmWC+SWUZ6EPBJXreuhogSL8MVy5JxIyFnB85CJzqqd/0IZZtO2uVXF2FMGT6v5EzdaoXCqdLyW+Adq3YsdRrqXxcLis2P8rCBIfRoALcaJbRtr2LNOWjLAJ/GLg+VNN2CocqsSV+YsBrYLxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462355; c=relaxed/simple;
	bh=kXnM/kY2SPptXwp4A5BojYTAHASKtf/xRW9k6y2jTOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNRkomsOgoetQ+TBrgNyNFmYe5JghG0RFzRsBaIT6HmGGXGM3EeN9uVxW1eCU0LQ2qBcGuxg542+Z0Xk1gUDHZV2jcM4ug51pCdElbBw7OlhajiKWCLhyDNdpbcT1GucPmnKOLxidgZ1vmWj+wmV0AloZOJIZBXYkXQgZvs2M+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8BxV_COnjBmHFEFAA--.17936S3;
	Tue, 30 Apr 2024 15:32:30 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxndyHnjBm3e4KAA--.26331S4;
	Tue, 30 Apr 2024 15:32:28 +0800 (CST)
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
Subject: [PATCH v1 2/6] dt-bindings: pwm: google,cros-ec: Do not require pwm-cells twice
Date: Tue, 30 Apr 2024 15:32:03 +0800
Message-ID: <231df058d9cb35cfcf4bcdf4385f4ad8cb21a046.1714450308.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1714450308.git.zhoubinbin@loongson.cn>
References: <cover.1714450308.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxndyHnjBm3e4KAA--.26331S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jw17Jry7ZF4DuF1DuF45Arc_yoWxKFX_AF
	srur4DtrZ8AFyFkr4Y9F4xtF15Xw4IkF4kA3WUJw1qka4Fyr90grykt345Ar17Aw4Y9F1F
	9a93Ar9FyrsrGosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxhiSDUUUU

pwm-cells property is already required by pwm.yaml schema.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
index 3afe1480df52..f7bc84b05a87 100644
--- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
@@ -35,7 +35,6 @@ properties:
 
 required:
   - compatible
-  - '#pwm-cells'
 
 additionalProperties: false
 
-- 
2.43.0


