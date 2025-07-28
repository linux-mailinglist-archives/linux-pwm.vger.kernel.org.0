Return-Path: <linux-pwm+bounces-6897-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0C0B13F5A
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Jul 2025 18:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34243189AA3A
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Jul 2025 16:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE74412E1CD;
	Mon, 28 Jul 2025 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R2r8c2ea"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3B725771
	for <linux-pwm@vger.kernel.org>; Mon, 28 Jul 2025 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718436; cv=none; b=gLNubnkCTtMiojoxDUQhtrtFtwKZRYz7lSEf2LNAOv393hcCRVXzgyHG8YPvhtUtCAMFb3NYpP4zAkZ+7pri7u7ClnSiBS8a436My9CGm3X3QnSJZ5kGt4jPnUq+Qgqlv46CvNP5Dx/eTV0INLJ+QLO7jPnz4qCEspWFRrFr+VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718436; c=relaxed/simple;
	bh=2+q/5rhSE3u+zzjJ4tVGln9+xBS1cRtjqFM5t5RSAas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uYtjEuu0lFHtRff6ByulJIIlX+ZL9uti2tlm9llXmbSAbC8uhloK5+gebKk+5ZJteRVBC+hGjRGCkIKHV/EzVM/aq8IBDeDh+tH5NQHTTsDg4HzngqOymAIXsR7rMcKi1/oPH0RA4jytyxL4B71SCteydt8xFFxyTXrpK1Jkspg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=R2r8c2ea; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae3a604b43bso752058966b.0
        for <linux-pwm@vger.kernel.org>; Mon, 28 Jul 2025 09:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753718430; x=1754323230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l1ihiDZ0+g0CQjEWIGP/e8TLvs2vqb7vroL9ke7v984=;
        b=R2r8c2eax5acA65qbQVr9NGQjqyY7FZAmrF4xz5QLNPcfSqekfXTB8FXfDk6o5A6Pg
         8O9hAQkARe5d8LiXFxdT9gvsSk57QxiE3lhTzHT5LVGx1SSxsQQzn7PoDcoXL8UeE78x
         7bZt2ktzzEdhgN3S2YsMYxO7osMZEAHwI9BQKv60BjwMW9wBVk+qFjnbwXq0mUZHpDPJ
         wMoUgLnxs1moXDsTFk9020C/KKowumPFwfRqlrnqDD2gVBQHd9jiv0PCu7v2OpuVPj/q
         N76UQg+mygSLaDKveQoV6bRA4TvUZ+evrcovXq0XNFNAvE4rmTvxciEllhfClqYBgFXY
         CWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753718430; x=1754323230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1ihiDZ0+g0CQjEWIGP/e8TLvs2vqb7vroL9ke7v984=;
        b=O0niGSGRCJGq/DnvqEogiAqWwjajKJAlWcCo4IWCy+SpI17cv24s5Kr8n06JOqCom4
         8kLi00Dg7L5XZvvwhxMfWlTHCnMTdRxAlCvZDOgw4vpi5QFX+Vm6KAq4/7qr6VT2wHTQ
         W2M88brSvCNFYUd3ZwSnfDQeyQaOcRKbmLuxup+kjuP2v8MqZN0j8Fol6OiGMnNEeoIy
         toPQB3uvfHiXg4/4XFs3Xl2kkUVOyVl5G1H4klHAz9hiSW9Jh6hmeoixFLyY/xXOxEoP
         /NxlrAWg6cUGkGiV0XBCrYQ4pjQHupA4C5Sc4veyQVKbXOcbqS+rfuSRdAolQQISzkQM
         z/kw==
X-Gm-Message-State: AOJu0YyQQtb2piUNiIn7ah8YnLUKrFDsfde/NOEGRI4pXVpZn4PLezec
	HHj+hSlyxvEq/HLQVnB70tgScpqWOKHSAoctUJdS0cTqMpeK7+44d/5ChiImQwnJbNg=
X-Gm-Gg: ASbGncsNKPilv9Wp0PKaTkOsW+q6cUPNEsmhOkN/63ccdfJhSgtky8lVwaYiL2B4YM2
	EZ9kCojy0gsDGNQKxQeiyP8XrluYuZxlBessxlDvGtoCnyJaEryKe952/nCcB7XPl/QjuDDCriz
	nbcepWH1HxS30167Tpt0jx8B/RJnNc+IUC+vQkrte/jAxP683lCaEhJBgTbXIMD3eeJ0BgxDcUx
	ApYjKYjdkCdnaxFYwv7Lksy2TAFBLhDPuGKetVu1Ec7xylMLtdP5Bi0WzWnz0r0EsBG7CY1XhT+
	9rZGZyQIx0PC2zrtSfuRR75J7wxXtz78nN3tf79cUOwmYVUz7A306cArTjJRxAxPvU3iwx1M8FP
	PDNZe3deVwwi6RXawBts/e30nkpdTiyp2P2MNcEF1z/Q7990cmxpCkebheGLDWPod
X-Google-Smtp-Source: AGHT+IH76Ks8kk8QfxzYyoYOpncwY0lKaUyHOdNOi1xFRfhhTJpRfivJmM+awRIlgh8fpuL3iWc7FA==
X-Received: by 2002:a17:907:96a2:b0:af4:11e1:f877 with SMTP id a640c23a62f3a-af61b6dd13fmr1194595966b.21.1753718430027;
        Mon, 28 Jul 2025 09:00:30 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-af635a610e2sm441327266b.68.2025.07.28.09.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 09:00:29 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	John Crispin <john@phrozen.org>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 0/2] pwm: mediatek: Fix duty and period setting
Date: Mon, 28 Jul 2025 18:00:16 +0200
Message-ID: <cover.1753717973.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1085; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=2+q/5rhSE3u+zzjJ4tVGln9+xBS1cRtjqFM5t5RSAas=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoh56RVgu+4nc+RdW9qr5CAHNu1V4qlofdKx/WM KOn65Lb4SmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaIeekQAKCRCPgPtYfRL+ TiZ7B/9VyhQHYZQKWjNvnWbKPuz4bKuBC35kuEAtmmNDotWdBSI14aAOAzg+5spMcaSHR/MJTOR zN0/J8S3GbN7p0I9bUV7ihguiBufeAqZijTtSZFMfkQHK3MCpyxyhszAFfMY7N8/y88vIg5D0Id d2n2i+GpC5ZzvlZzOQjbY0fvakU24YcfcnP4mgwvrBkwf2GYs3chwVClQMrGD2HbktZdBZ4Juvj GER/UTYzxrGosPO+U9vN9xLZYzr2oki0uC4HMRW6VVEauRhQ9zZYK6+3YLe11sJwdPDvvwfgula yq+uBKWv9facsWgVAySSgWrkZHy2fYuLwBqRM0Dq++aK2Ou8
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

here comes v3 of the (formerly patch, now) series to fix duty_cycle and
period setting for the mediatek PWM driver.

v2: https://lore.kernel.org/linux-pwm/20250724210041.2513590-2-u.kleine-koenig@baylibre.com

Changes since v2:

 - Split changed clock handling into a separate patch (suggested by
   AngeloGioacchino)
 - Drop

	if (err < 0)
	        return err;

   just before an unconditional

	return err;

   .


I didn't add a R-b for AngeloGioacchino yet, as it felt wrong to do that
for a patch that he didn't see before. So assuming you're happy, please
provide the tag again for this v3.

v1: https://lore.kernel.org/linux-pwm/20250710163705.2095418-2-u.kleine-koenig@baylibre.com

Best regards
Uwe

Uwe Kleine-König (2):
  pwm: mediatek: Handle hardware enable and clock enable separately
  pwm: mediatek: Fix duty and period setting

 drivers/pwm/pwm-mediatek.c | 71 ++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 34 deletions(-)

base-commit: 68b9272ca7ac948b71aba482ef8244dee8032f46
-- 
2.50.0

