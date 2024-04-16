Return-Path: <linux-pwm+bounces-1957-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 760A28A707E
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Apr 2024 17:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C0B286078
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Apr 2024 15:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8517E139569;
	Tue, 16 Apr 2024 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DrMG92qM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6568F13848F
	for <linux-pwm@vger.kernel.org>; Tue, 16 Apr 2024 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282815; cv=none; b=X/AGzNUUhWm7+IC371KetoPG/LqrfNoNV7WsyP4zfSn0RGTAHXIVq85SzQ3E2mc4kK3vfWjduoKcm7S5BwX8pD2ybk9Qa0DiOru2iq2xw7QII2Vct1dihOslf1NKxdhtvggSwgajl81hbT+ZIMg/iOcksIQhCygrDLZ6yLou2jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282815; c=relaxed/simple;
	bh=epD3N8w0jJEyk09IJE2WmrV9SFTYkbtEoVXZX4ZLDLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LxwlgHdwxW2FTMdCc+iHF49JdHGe02Qs0q5iPV+Fujdf7wBqXviz7lhomp/QZjtHBHseWgMw8f3aRDgiYojualNYe2eQHuhvZpE6OE0hiUgZjDnsNSgSeaWab817oOOyz6PmUIav9YjVqtAogYjSbH8ItnI5N5R54a+U3xoaITQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DrMG92qM; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57042f84cabso1317033a12.2
        for <linux-pwm@vger.kernel.org>; Tue, 16 Apr 2024 08:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713282811; x=1713887611; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xlsoknBYQWG63sDwAb9jwt3WWTGlyxEUyggNRmjx7kM=;
        b=DrMG92qM77oevs+L3qdlU3EZj0RQcfQGTpw/ctL05w8w3Eu5z+4cwQuZ/VDEk/rfsF
         ssz0jQDgXq1qrICh3Mh54n5g4qCMQ8hgayvUfjSI/6IK8/7w0usoFu+26zXKSzApEXVx
         3Rm36MHcs5klvEoFL+dp3NJw/QvFVoq//1qS2cLJOyXB4ommzNv8vmSGauwX/CAsP8d2
         2oJE9ZruM3/P1nzK9GXi4mLRn1u/pHs1Kchr7nK6zXam3t11PzAAEqSPJyMmKejIkDAU
         uL5vpLK6P1P4OT6udnM8XxZg/k2JA/iL12MhbGd6l/1EdGzRg5ZWYE4+W3RMXBC8ykry
         36hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282811; x=1713887611;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlsoknBYQWG63sDwAb9jwt3WWTGlyxEUyggNRmjx7kM=;
        b=lQ0EUPU6SWhkmXRsY2JML4ls/aLdyVlk/eJTXGNAH+LdH+DAjcrGChxV8g5vGesxc9
         I51tw+/ydKxslwpPmywRikQ+Ox3xh5QYelr+TEL0ltUU1SPlX0Hw0CsruUPSFK2sGAD9
         Pee3ihcY7PYYO0INwSH1RWl2HaXL5tdHJGcEADzjJq2j6zrwwSyD5pjtI1s5GiXebgW9
         Nm7c/lvxUpEVkGAAmN5gvs/nYCNMAZUiYCwrrb7O3PhGkeESarpyewjtyU04Qy0i8mKI
         SkR3jV4ZoLJEaqXREdMnwRFNSMZcj/XVdHjicYP5vkS4RHR9RE2GRCUrJb7SLCg8zKJl
         wo0A==
X-Forwarded-Encrypted: i=1; AJvYcCWHYa8GLJ+ga8/c27Rl9PGw2QhpPirNpO0vN7E6Dfm//A+RVzl9yiMmlyd0OgcO/fCS23lHGu9PjKBxVrt5kZPm9SC22cre2Mj6
X-Gm-Message-State: AOJu0YyIXEnbFPkCUQ+igePCqJSen4kRUc9YxCvlOm7NtsI9yONsMT0w
	OZ+iqOBNQdCpyPIa56iN+c3WlU81QNdyF0PmZQ3TXiqF5dinutxeOn48gW8l9DA=
X-Google-Smtp-Source: AGHT+IGA5RRSl4A2IXLKdqCC8v2L1AFQuGr2B9Nnr9Br1rPnc/6ECo2w8uyg7/0Z75xZ472LbU6zfw==
X-Received: by 2002:a17:906:2a4e:b0:a51:dbf7:688d with SMTP id k14-20020a1709062a4e00b00a51dbf7688dmr7549912eje.74.1713282810826;
        Tue, 16 Apr 2024 08:53:30 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d12-20020a170906174c00b00a52567ca1b6sm4156691eje.94.2024.04.16.08.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:53:30 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Tue, 16 Apr 2024 17:53:09 +0200
Subject: [PATCH v2 08/18] dt-bindings: display: mediatek: gamma: add
 compatible for MT8365 SoC
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v2-8-33ce8864b227@baylibre.com>
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
In-Reply-To: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-clk@vger.kernel.org, Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=905; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=epD3N8w0jJEyk09IJE2WmrV9SFTYkbtEoVXZX4ZLDLc=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmHp7qh6M0l8VmBY7ocshqa+6uo7JC8yIk9Ue62Bd+
 y9gsJDOJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZh6e6gAKCRArRkmdfjHURSvSD/
 9PZbD63pq4febDhJFNmCj5B5acPQcLv/gCpAp99s2w9KioIW5GWsqXyPuedu/n4e9uCLdiI/IdAGOH
 ovoqBfzKu9Z2lsHBui/NWLvGxBECzLrVenhmmcvOnZw8FXpsqSMCtx1SXCMph6PZZybI8i/wyfsz1C
 L1Zt7Esgqaj2as95mbOj4VdcEk4wxFtGCsWDSgp8+4XXfwg0TnQrg2iMMFPFFlqNNaV60lhSLtirF0
 XaEXhJ9ssDgoo9eHyiErFwDQnIvP/xn1I+tf4sREFMd+UFyDy//PwPdJLC9zVIqm55z8l4hRahw7D4
 HrQe0QfgkFOfxloqambBH/8I4C3mw04e4bti5mA8rr8LGqJLxPbvJwvnRseF6RSuKyu/dIMCPsdgPO
 0CV7eN7iylz5KWgxt8mCOpA9BC/19D5H4e/FKJK912tjOAuO5WEYrf4ByzIemd2v7jsufUiE5+hWOi
 62db6yvM/RL7Vzb89SkhZLAUJSdID2Q6c2qxIr70Kam/JJ8XScBVTW1kuNP/tokRnRFmv1vcg9GANe
 oC6Q5z7XR5YLhVIZpeltJ3/hPoxhIImza+apacZf2LXGd0OrCIEF+f2YjY6VI6vULEULXkAT1UBW39
 mxRsafZLI2HQjJvJvKtAczF7AWLoTEeSYF0JlQfyRYqHpuftGEOUMmFLP/Mg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Document the display Gamma on MT8365, which is compatible
with that of the MT8183.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
index c6641acd75d6..f447f4320e8b 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
@@ -34,6 +34,7 @@ properties:
               - mediatek,mt8188-disp-gamma
               - mediatek,mt8192-disp-gamma
               - mediatek,mt8195-disp-gamma
+              - mediatek,mt8365-disp-gamma
           - const: mediatek,mt8183-disp-gamma
 
   reg:

-- 
2.25.1


