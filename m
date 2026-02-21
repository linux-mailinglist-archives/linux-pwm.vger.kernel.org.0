Return-Path: <linux-pwm+bounces-8141-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKHHBUD7mWnUXgMAu9opvQ
	(envelope-from <linux-pwm+bounces-8141-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Feb 2026 19:36:48 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B4716D865
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Feb 2026 19:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE2B8303B5F4
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Feb 2026 18:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0665230DEDC;
	Sat, 21 Feb 2026 18:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsvkvPHy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433D7221721
	for <linux-pwm@vger.kernel.org>; Sat, 21 Feb 2026 18:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771698998; cv=none; b=jFNwmi3NK4SrJFt2eq0PjIkUHve/aOui1w6lOVNvN730pll6OSx7JIxsrfarxqrhS6de2bC5c/QzC3PNbDcHh52bJ6duYfLQCXKCNbZWPkv+S7fl9/Fcj2PAFtyJR9FCgaS2IVZact3P1uZ76nibopK/Fo91a/7cJ2VInwJI4n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771698998; c=relaxed/simple;
	bh=Bp88nInx/+y1nve3gCqs9RuKa1fpBoEP3C+mMJqdiTE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D7tTVgoFDNFSQIWHIKz3DCEUi7EajbHpTwhKcmmqqbxW/JdlWRf2u8JpUV5pA+6TI38OkZdX8FGkv8F/KJL2tyPb7TPuPM3DRKtkuVSyijuc904t+1iPcyYb4azZUjFwcBdDGGFiJCvudiy8UhqwoQki+wWvcpn7Z5BVtb9ejh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsvkvPHy; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3870dec27f4so36793091fa.1
        for <linux-pwm@vger.kernel.org>; Sat, 21 Feb 2026 10:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771698994; x=1772303794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XJ4mlxz9+qmH9SFVDphbLCUFby68qXbPqoJ0t+cVd+E=;
        b=TsvkvPHyhXYWkTT5w1JYhWzKq9mf9TqmZcjw3cjHIjfh+E2BrpykvmXpAUBUvQtS/G
         BiirQKLhjZJmNtvhqPYXBYPoPqPSrpRcq3OE8T4sJHmHIZ0SsyeT67A5wAQa6DNENrGm
         XVWVSOrUzhwICu+mpjBqKnJJHR/6Iide5iUg7SIOZ7bqmX+EbY0g/wAubvbBAYaucUSO
         xUr1SydxBpr7K8zU5YkQ55Oj2OnFG0or0txJVOD5q/ETIQE4uGffOAEb5lpTLdqRZRL1
         ispY6A+y+SzF2StsUv4+vIL92LezkDh6lBXCekM+n5Xbvt+w/iaMkC+1CuoUa+lJwOSN
         BvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771698994; x=1772303794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJ4mlxz9+qmH9SFVDphbLCUFby68qXbPqoJ0t+cVd+E=;
        b=ASlfrR4LrthmU63PdNEVqlbWxIzf2xvm6GyFGxx8reO7vO8t6bo+dDiWg/861RG18t
         AWqfWxKYI6CJgK7VNyTmtxnPbDWS3DD50Ts7eFG6mp7OGUIuBuTXMv2B00PvgvZMFyiL
         GQd+H23x32kRYeE6HJRohjs5MFxYkJQR0hiZY2BjUPYTKtOrkaNbv+BMdL3zmXrqRSsu
         iqMzt0/V4Cr3DQKibUH0XZknFAFRkYcSCl65Ih+6c+JJ38iAYSURrSa2zMc8jZs5vT/w
         mEpePOEmZ4hiqDwn2cAOE04o6ar6A74aekCzgfGNQTnDRkq3oKsdKJ0F+PGwZoc1oYK1
         IeqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0PVJz3B2AbojPcIKudiTgNoFP7wI1u758yef7dmDuOjuO3esUTkKQ6bTIl4IQIEw3v56rRhW9Guk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3qepmBQ80EZncvzyitn1DaalyXQfJDvkD74lIazwR3fuF95Lo
	nsIj6gcoNBqxol/G9Vh3jl5b3afhnyEzil71tx+rtfr0EsBLurZlj0o=
X-Gm-Gg: AZuq6aL7bs95WxtZVzNcfCUefZtcKq8GfvVePKe7lGWd6RWceE2S03XKwEqwdAKP4Rb
	JzoTUGrQmDGmKrn7L/c4dUB1FXB/41+9cipVbTXxU5ZI4qrgnYfMljuhnV1uPE+eP8UVLPIFPAV
	6wJUErFkoKzzBsc1d0VNf2xs8X2YMsZzDCqo0uPl5lLZR2I/h8T8s6iYGoT1rgSMmevx3WJU58+
	8OCxKRUloS3+CZOjwYekx8UN0O/P0o88tsagJZeatwJVy+J1pDgix9IzJe0PsroKOZkjn4hOOfP
	3LL14korQzna7Hf66gq0JPHmftFGm252gIs/pBKp1esgoZaNxHyHOjoD+9+yd+arMwUAWyxQBdm
	J3hT0FYMumpYO/+N2nNh2lmTqQnQiNWTt8LYWab3aHUKnf8/O0FF6stoTMQXd7oOgCn4pUswHop
	loeWgRV2Xv5Tcxq0DL4H9Ur/oMkC+1HzWrvNK/gCjxSfAK/uk=
X-Received: by 2002:a2e:868a:0:b0:387:e03:147c with SMTP id 38308e7fff4ca-388536cef04mr25730261fa.1.1771698994175;
        Sat, 21 Feb 2026 10:36:34 -0800 (PST)
Received: from localhost.localdomain ([178.176.177.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389a7af19d4sm5006841fa.42.2026.02.21.10.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 10:36:32 -0800 (PST)
From: Aleksandr Shubin <privatesub2@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Aleksandr Shubin <privatesub2@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lukas Schmid <lukas.schmid@netcube.li>,
	Cheo Fusi <fusibrandon13@gmail.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: [PATCH v13 0/3]  Add support for Allwinner PWM on D1/T113s/R329 SoCs
Date: Sat, 21 Feb 2026 21:35:50 +0300
Message-Id: <20260221183609.95403-1-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,sholland.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,netcube.li,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-8141-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[privatesub2@gmail.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0B4716D865
X-Rspamd-Action: no action

v2:
 - fix dt-bindings
 - fix a remark in the driver

v3:
 - fix dt-bindings
 - fix sunxi-d1s-t113.dtsi

v4:
 - fix a remark in the driver

v5:
 - dropped unused varibale in the driver
 - fix dt-bindings

v6:
 - add apb0 clock

v7:
 - fix a remark in the driver
 - add maintainer

v8:
 - fix compile driver for 6.8-rc

v9:
 - fix a remark in the driver
 - fix dt-bindings
 - rename apb0 -> apb

v10:
 - fix a remark in the driver
 - fix compile driver for 6.12-rc2

v11:
 - fix a remark in the driver
 - fix compile driver for 6.14.0-rc2

v12:
 - fix a remark in the driver
 - fix a remark in the dt-bindings
 - check driver build on 6.15.0-rc3

 v13:
 - rename driver sun20i -> sun8i to reflect wider SoC coverage
 - drop the misleading APB > HOSC dev_info() warning
 - require allwinner,npwms and validate it as 1..16
   (remove default 8 and silent clamp)
 - adjust clock-source selection comment/logic:
   when sibling is disabled, pick the faster parent (APB vs HOSC);
   when sibling is enabled, keep existing shared settings

Aleksandr Shubin (3):
  dt-bindings: pwm: Add binding for Allwinner D1/T113-S3/R329 PWM
    controller
  pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
  riscv: dts: allwinner: d1: Add pwm node

 .../bindings/pwm/allwinner,sun20i-d1-pwm.yaml |  74 ++++
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  13 +
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-sun8i.c                       | 393 ++++++++++++++++++
 5 files changed, 491 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i-d1-pwm.yaml
 create mode 100644 drivers/pwm/pwm-sun8i.c

-- 
2.25.1


