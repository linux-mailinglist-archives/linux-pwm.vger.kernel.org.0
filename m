Return-Path: <linux-pwm+bounces-1762-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AEF87C468
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Mar 2024 21:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6E61B213B4
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Mar 2024 20:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A277D763F6;
	Thu, 14 Mar 2024 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rDOYjRtu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776CF7581E
	for <linux-pwm@vger.kernel.org>; Thu, 14 Mar 2024 20:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710449247; cv=none; b=Kc+SwVWs/q0RXamG20NpiKwWSfWpXhoAsZ1yoPJ2C3zHIVeAv8iYo5Ez2cq7jt+ry7DxDPk1lW1BQQZeSCyH27dtiFabARGnepnXKqjrCzcGlOxZjwUA9d+QRxyrjs0bpUbO3A3FpvNVMMH6UY/JuCoEw1VSREjso9bXXUMq8qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710449247; c=relaxed/simple;
	bh=du2WT+/IhUMepIGZbpvZTbMkHPvk1mSEq7tDbAeTApc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LuonG1b2JJPl8DLvdQIi+3b20A+bZaQf1wnyoh+cDu9trto1vXUX4UKqbZiLnUobQG/BtGrLXpx+VQHzyEh6C6EClrXlffgvWrZ1UvlcjotwhQTbNdYo4cYEgZFe7zPTMwkLy9yzEFmdP6GBUMqtVRX00rpLFX3hYdNwERotmqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rDOYjRtu; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-430a0d6c876so4883431cf.3
        for <linux-pwm@vger.kernel.org>; Thu, 14 Mar 2024 13:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710449244; x=1711054044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EerKNIlRapC7GXPSamOoOowoFZGKR33EHS6GaKW+Uh8=;
        b=rDOYjRtu2HmbUl4wLBzA5VoTOA36Y7b7QNRPp5Cy5B64Bri9SRmJLwsP6uAtt757W8
         OWwYMMNO8wsp3Iv7UTvU8FYKsjcQ/MkHxuNBQJ9gr4HUiTDzw2O+GeUBFJEubxB0gUZz
         LYVx1f09JYnT1GyIz9pHCxUsPPkHR448rYFRV7lpdKfElbWgSi+uao+6YvRSKdnTiH+X
         nxJjtVovtD+3BUxwUxbg/kZgS52HQArw0gM9EwITChdlJkaxTP91kz5rtLcOr19hLzye
         B/CP1lIlC3pb3gRr3OEF5XlN5NMvmLq3bwmr44q5EYgMBAY2F7v1LiLQLNuuu0xSaRhC
         w6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710449244; x=1711054044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EerKNIlRapC7GXPSamOoOowoFZGKR33EHS6GaKW+Uh8=;
        b=Zwe5LzmcsmcAUu3npoq/51QGFxgsLb5O1scYZkzLwd+NcN4g7p3eHWvrI0kItY/SOU
         gNBI1m7XeUOIjKSk6QjxG1VoL3PxfGIau6pWDarY6YlJEctkxsRyOX0ogIkGTqyIJCqr
         mgWsv/iEa1JydrHXHmHEGSFtFOkO8/f5b4ptCY6rDA1fhnhh02NKPNaFR5DMtcaNoJ5f
         Qkh0ysYFd1zRWUMIDCaZc/jpVUdWJ1knDH9GOsYzGuh4ajEVhxy0Rf4z2JamO8/suiFa
         zJczO7oSO97HeWpog0v5ic09I8J44RAypruWmzEgfisDW7y7iEJkip7ez5ICY79l/u4o
         Us5w==
X-Gm-Message-State: AOJu0YzgC16pnAZz49QrQdburOuoRa2pVcL3G6gkUYUAKxj5ScIeoYjv
	Jj0/K2jTU3ejU8V/6T/1kqegt9sXmjrdRj74xyuLwdgu5v2YiOGcH3Noqx1BTka09cb1uuR8X0Y
	hLzc=
X-Google-Smtp-Source: AGHT+IGl2GL5Qyuks42rePlMkrmMzfUZYkVbUfiyA5FKYet4juESL0lsdZbw/hVxxOgZbGAjHXjPOw==
X-Received: by 2002:a05:622a:5488:b0:42e:b90c:cffb with SMTP id ep8-20020a05622a548800b0042eb90ccffbmr3186362qtb.51.1710449244321;
        Thu, 14 Mar 2024 13:47:24 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id n16-20020ac86750000000b0042eef160b4dsm1165272qtp.76.2024.03.14.13.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 13:47:24 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	tgamblin@baylibre.com,
	dlechner@baylibre.com
Subject: [PATCH 0/2] pwm: axi-pwmgen: Add support for v2 IP
Date: Thu, 14 Mar 2024 16:47:20 -0400
Message-ID: <20240314204722.1291993-1-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for v2 of axi-pwmgen, which allows for up to 16 PWM
channels (instead of 4). The series was tested on actual hardware using
a Zedboard. An oscilloscope was used to validate that the generated PWM
signals matched the requested ones.

This series depends on [1] that hasn't been picked up yet.

[1]: https://lore.kernel.org/linux-pwm/20240301173343.1086332-1-tgamblin@baylibre.com/

Trevor Gamblin (2):
  dt-bindings: pwm: adi,axi-pwmgen: Add compatible for v2 IP
  pwm: axi-pwmgen: support version 2.00.a

 .../bindings/pwm/adi,axi-pwmgen.yaml          |  6 +-
 drivers/pwm/pwm-axi-pwmgen.c                  | 62 +++++++++++++++----
 2 files changed, 53 insertions(+), 15 deletions(-)

-- 
2.44.0


