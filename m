Return-Path: <linux-pwm+bounces-2136-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAC38B6BD9
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Apr 2024 09:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF12F1F2195C
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Apr 2024 07:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B342D3FE3D;
	Tue, 30 Apr 2024 07:32:35 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A49533C0;
	Tue, 30 Apr 2024 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462355; cv=none; b=fwl32hjEiVcT+J89CnEZEf4NvKYeCnlOlRWscqyMleJOW5pYSobF/J4qYXKeqv6wMl+EDud6U9aqFsM++z3/yo0xz7fK0ewbNXdVJYwBa2T5LNKOQWnfKr7gHmynV2i5MlDQ6gP9ESDEAAs5ZlBiumpgoFJiZNN/32bw404fiEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462355; c=relaxed/simple;
	bh=YywLMa5JngQdwURvlarf+/PS1Q57JpxjMbxqUn5EqTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YN1Hflh1yrjTSUS7PztN1sML0iBvGr+21RCnzGg2kbLA7ud14LM6Of7Em086DPKXpE2jN6zynwck6N9G+WgDX4QB0UG9Uh/oy8kp7vHCSxioidwn77wxGjV3DG3hZFHGkpBC2iGNziEIeUJ6e/FDHF9gQY5TfnacdWp8Vg1pD5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8AxaOmJnjBmEFEFAA--.5384S3;
	Tue, 30 Apr 2024 15:32:25 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxndyHnjBm3e4KAA--.26331S2;
	Tue, 30 Apr 2024 15:32:24 +0800 (CST)
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
Subject: [PATCH v1 0/6] dt-bindings: pwm: Cleanup pwm-cells required twice
Date: Tue, 30 Apr 2024 15:32:01 +0800
Message-ID: <cover.1714450308.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxndyHnjBm3e4KAA--.26331S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtFWUXrWkZr48Kr4kAw48Zrc_yoWkuwbEya
	n7Z3WDXrWUArsYgrW5Xr4xt3W5JFyfGF1kCr45Jr1vkry8CrZ0qFyktw45ur47GFsYqr9Y
	y3yfJFW7XFn7KosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1EksDUUUUU==

Hi all:

When I was submitting the Loongson PWM dt-binding, Rob reminded me that
the pwm-cells property was already required in pwm.yaml and did not need
to be repeated.

This patchset attempts to clean up the required pwm-cells attribute twice.

Thanks.

Binbin Zhou (6):
  dt-bindings: pwm: bcm2835: Do not require pwm-cells twice
  dt-bindings: pwm: google,cros-ec: Do not require pwm-cells twice
  dt-bindings: pwm: marvell,pxa: Do not require pwm-cells twice
  dt-bindings: pwm: mediatek,mt2712: Do not require pwm-cells twice
  dt-bindings: pwm: mediatek,pwm-disp: Do not require pwm-cells twice
  dt-bindings: pwm: snps,dw-apb-timers: Do not require pwm-cells twice

 Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml    | 1 -
 Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml       | 1 -
 Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml   | 1 -
 Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml     | 1 -
 Documentation/devicetree/bindings/pwm/pwm-bcm2835.yaml           | 1 -
 .../devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml         | 1 -
 6 files changed, 6 deletions(-)

-- 
2.43.0


