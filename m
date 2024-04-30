Return-Path: <linux-pwm+bounces-2140-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A248B6BE0
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Apr 2024 09:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69A61C21FE3
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Apr 2024 07:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C674085A;
	Tue, 30 Apr 2024 07:32:59 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB9739877;
	Tue, 30 Apr 2024 07:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462379; cv=none; b=U3p+qS6eaGphGOqt9ggI8usveKhP6NrbzIWWk4rIZQMMvJzjCUtLtQONkYqa8zBmoAm2Wfmk84kgCDW5Hw4VQ6lnSCTqWph4rJh6jzcpjGWg3q0tipKK6AUsqqpIUrN1VkOHd5Cw1zKB2MifmqLgV292i50fGFw7He3+BnP7WeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462379; c=relaxed/simple;
	bh=uE90YwaV/x9ki4M5zMDZtSXvKM7+QamDGCV1IH+ToCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZpNRmI9iIbTsZbOsCCd3ZjjGqWzycoNzwMCz3rX2cCRG+X152OzqCLK0jOE5ROuHAAWQOXv56T8WYpIkJdAvlRmiNW7sdBsoAPdQ4Q+OfzgGmyzuV4lcg7oa3LkeTJElCrgzz6mtYQtNetVO3PvUygpxPIYFbaiEY3xdjgfq9w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8Dx_+ulnjBmL1EFAA--.17916S3;
	Tue, 30 Apr 2024 15:32:53 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxhFafnjBm+O4KAA--.9736S3;
	Tue, 30 Apr 2024 15:32:51 +0800 (CST)
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
Subject: [PATCH v1 5/6] dt-bindings: pwm: mediatek,pwm-disp: Do not require pwm-cells twice
Date: Tue, 30 Apr 2024 15:32:35 +0800
Message-ID: <480bcdc37958a9d99f4b61c26a13b844a1e416df.1714450308.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:AQAAf8AxhFafnjBm+O4KAA--.9736S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jw17Jry7ZF4DuF1DuF45Arc_yoWxtwc_ZF
	n7Aw4DXrWrAr1Fgws0yF4xtF18Xr4fCF1kCa1DGr1qk34FkFZ8JF9Yy345Ar17Gw43ur1F
	9a93XrW2gFnrGosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbSAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j2MKZUUUUU=

pwm-cells property is already required by pwm.yaml schema.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
index bc813fe74fab..415730f078f5 100644
--- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
+++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
@@ -58,7 +58,6 @@ properties:
 required:
   - compatible
   - reg
-  - "#pwm-cells"
   - clocks
   - clock-names
 
-- 
2.43.0


