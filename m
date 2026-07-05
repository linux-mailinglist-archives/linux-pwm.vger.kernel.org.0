Return-Path: <linux-pwm+bounces-9572-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yRSvDeF0SmrEDQEAu9opvQ
	(envelope-from <linux-pwm+bounces-9572-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 17:14:41 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 837F570A6C5
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 17:14:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=PD1I2V8A;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9572-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9572-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 140103009147
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Jul 2026 15:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C20D38A71B;
	Sun,  5 Jul 2026 15:14:38 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5037D3815FB
	for <linux-pwm@vger.kernel.org>; Sun,  5 Jul 2026 15:14:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783264478; cv=none; b=jey9goSXl3KeBOgaKriMdFpzArRtJjtKwgWX39Ioa/1OuPzv7uQxNY0KLoxQ7xSu5IORAOAGXUmROOGRbqsO5P2C09xIOv9I64R5zMYtT9uD1+UmUFilJNN8zPf+XD7yjUTLrQETm3BI/5xnyI7JH3/no7xfyIcRfIPh1Tot8h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783264478; c=relaxed/simple;
	bh=/ARYZ3nMFNE4qw1dHISvtgGeE92jI229vSRxfVl732s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GlzmIz8zLc4V8ZQE6wi66lEMBli54jwajkbb/zrAFNTg48BHSM0M5k33ePOl9IKmyxqGJJRsyquEBW21GIAKxzZdUBssiQVFFZ4rpDxMB3Rq+RRSpSQpKWBWsK9Yy2dr3IbMkRJFJHi4oUoemFTCc5Kf1ngmAtE0m8BnYy1mHeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=PD1I2V8A; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b61b52b6so13866605e9.1
        for <linux-pwm@vger.kernel.org>; Sun, 05 Jul 2026 08:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783264474; x=1783869274; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W1sbIzpLoPVOsWAp5a91/2b+hubQz3OERKvp78vmABs=;
        b=PD1I2V8A5KdEME/1KcKwaX7YqOfPMzSF9mRgcdyyOh1GXWDyi3zuF3fIMgSb0q1DIa
         oHXj6JhPq2mpatWUKIM5n4QcOZpC1WDsbLeEKe+7tIYiolbZf6IDGjIdEv64lOg2/UIc
         PGX/0akQx+IdpOtb/WS9wReP0M/TwtyhcHsvcNaFkITYJnQ1mplUJhXtDSnfDseNufm9
         VXvosP/HQKlTfWyzAaxxBEngTrcrdv4WgOnEHNe1u5PnExNBGsBj4M2gJI8TPX33IgOj
         sDfZP2/Y8gPWC8m/Da9acriEbPg/5Sr2RZZOyhcKTEdlzpaQ/1npURWN9TamRtymV2oK
         nr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783264474; x=1783869274;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W1sbIzpLoPVOsWAp5a91/2b+hubQz3OERKvp78vmABs=;
        b=YAOFHlyvmUPOxfJnHq3NxEucp3uk22RWogN9m453m3sc/Nmlv3PVkm9PdRMZvCa8i1
         NV/UI3a/Y0W9Vymhf85FT1lGmkjXtrROeQAZgmEi5lI3cX048C7J0vRSbxERxoqP21+7
         csGhR/5bvaEvg5NJfnvDLVwDqmCFxu6qP7ZuZmbkxFYF9U0BaPcilvp+uifeYxIhD48R
         GVO6SY4nlWCxxJuB273ezLRnQ8YTlKaSkb6ews3Nkwqvh2fr3bQFJOQmmyj7zN9zvPXX
         3Tc0UFM09tfLgw21J4R0H5RnRVnDsjBtLn4yxileCkhiAIqoJgKisqPZVQkJuec/QTUP
         btwg==
X-Gm-Message-State: AOJu0YyLe44M38uNjl1HMSMrL/0XFv5zWdgQJsrkDdT4mR37yyTDKBr2
	jmEbgS/o4a77gTh6Pf2DKsnTKRetXUa8ibBWq7J/7YHQOB3neispv/G28zd2Oi4OF+CI/M5AFDm
	hDAU0
X-Gm-Gg: AfdE7cl6LJUgmRqQTwZOYUKb01O/+BQXKzqaS5wp+IQHY8EVXmWhgkrLu6859g+oV4M
	FSIxi5ec1kniMn7n9404oRP8H1pY/qGDKYtyyebfJ8+tHKUzKPSCiFISRqMgo0nGilqciF1uihp
	qgsDno4BB//HxsQJBiiI4QTpIjAl4zQSqb3QJGPBh4n40+s9rP42kUYLzZu0QHXiji0bBRMZ66u
	B3ayxNomgoqxFuu2whsc778LOPNtvNPk3wn21FPOTpr+tPBYlb7FVVtfox6Wog/5JCxkzYUBkg9
	l7qIZ9BW9aEzgZFB1h7DYgzdXvOsJ03lvDGb8hbpXEAeKgjalR07qHQZDtE38kbEaaFK9BiPTi7
	zROWxg6x6gPZMcwftfpbLJ1jwxoTguhzwpya/n3CcIh6+DvDGPIU9c+Um0GivUfNqxCO95kD1c0
	k8sGJSS26f+P1ya0RSnA==
X-Received: by 2002:a05:600c:8b61:b0:492:7084:32af with SMTP id 5b1f17b1804b1-493d11f4b80mr87345205e9.23.1783264473096;
        Sun, 05 Jul 2026 08:14:33 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493c63b6f8csm262180195e9.11.2026.07.05.08.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 08:14:32 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Michael Walle <mwalle@kernel.org>,
	Chen Wang <chen.wang@linux.dev>,
	Inochi Amaoto <inochiama@gmail.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Hammer Hsieh <hammerh0314@gmail.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Alexey Charkov <alchark@gmail.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Michal Simek <michal.simek@amd.com>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	imx@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v1 0/5] pwm: Unify arrays of various *_device_id
Date: Sun,  5 Jul 2026 17:14:12 +0200
Message-ID: <cover.1783263835.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3597; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=/ARYZ3nMFNE4qw1dHISvtgGeE92jI229vSRxfVl732s=; b=owEBbAGT/pANAwAKAY+A+1h9Ev5OAcsmYgBqSnTF02HXaqUpIDE1Mt23JzG4uWfnR2u11awWU 3umjMoAUj+JATIEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCakp0xQAKCRCPgPtYfRL+ TnxCB/i0tqSm4WRb5bStOYawCPIjfRWQcr4xSi/+9osjT9WCMkOFcdJIALH3OTjRDssO1bo27Lf HlxVL0NC+cyu2/kdQnTKxCwlN4Mr+K0ubzHhjQG0p5hKoo0E+ymyawDtJ372H29L5zSSYeZCvIo x4WE6N9MvkYqMFbIYzoBUakF9cYdVbu6ohyBqtXYSqr1ZwGjdHd4MWHija/sPCTtV/LrwSg4fhc gQCbrGPW2Y9VKehuNTAzHv2wje5Cu3eNO+c3uV15dBMdPgO9DfEp3EXIwH2ZR09Uaz5HwWXbYK9 FN+Z8CfZYziZ0D7HLlPGgse2ncweWpObjQ6pQzued8YQFKE=
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9572-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zhoubinbin@loongson.cn,m:sven@kernel.org,m:j@jannau.net,m:neal@gompa.dev,m:nicolas.ferre@microchip.com,m:alexandre.belloni@bootlin.com,m:claudiu.beznea@tuxon.dev,m:rjui@broadcom.com,m:sbranden@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:florian.fainelli@broadcom.com,m:bleung@chromium.org,m:groeck@chromium.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:kernel@pengutronix.de,m:festevam@gmail.com,m:paul@crapouillou.net,m:vz@mleia.com,m:piotr.wojtaszczyk@timesys.com,m:neil.armstrong@linaro.org,m:khilman@baylibre.com,m:jbrunet@baylibre.com,m:martin.blumenstingl@googlemail.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:heiko@sntech.de,m:krzk@kernel.org,m:peter.griffin@linaro.org,m:alim.akhtar@samsung.com,m:pjw@kernel.org,m:samuel.holland@sifive.com,m:mwalle@kernel.org,m:chen.wang@linux.dev,m:inochiama@gmail.com,m:ors
 onzhai@gmail.com,m:baolin.wang@linux.alibaba.com,m:zhang.lyra@gmail.com,m:fabrice.gasnier@foss.st.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:hammerh0314@gmail.com,m:nobuhiro.iwamatsu.x90@mail.toshiba,m:alchark@gmail.com,m:sean.anderson@linux.dev,m:michal.simek@amd.com,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-rpi-kernel@lists.infradead.org,m:chrome-platform@lists.linux.dev,m:imx@lists.linux.dev,m:linux-mips@vger.kernel.org,m:linux-amlogic@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-renesas-soc@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-samsung-soc@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:sophgo@lists.linux.dev,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-sunxi@lists.linux.dev,m:martinblumenstingl@gmail.com,m:matthiasbgg@gmail.com,m:geert@glider.be,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[baylibre.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,loongson.cn,kernel.org,jannau.net,gompa.dev,microchip.com,bootlin.com,tuxon.dev,broadcom.com,chromium.org,nxp.com,pengutronix.de,gmail.com,crapouillou.net,mleia.com,timesys.com,linaro.org,baylibre.com,googlemail.com,collabora.com,glider.be,sntech.de,samsung.com,sifive.com,linux.dev,linux.alibaba.com,foss.st.com,mail.toshiba,amd.com,lists.linux.dev,lists.infradead.org,st-md-mailman.stormreply.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	RCPT_COUNT_GT_50(0.00)[67];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:from_mime,baylibre.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 837F570A6C5

Hello,

this series is part of a preparation for changing .driver_data (and
similarily named members) of *_device_id to an anonymous union.
See e.g.
https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
for the idea behind it. I also grabbed the opportunity to unify the
coding style for all these arrays while going through these.

The patch series is based on pwm/for-next + "pwm: pxa: Depend on OF and
simplify accordingly" [1].

Best regards
Uwe

[1] https://lore.kernel.org/linux-pwm/20260705083910.3502207-2-u.kleine-koenig@baylibre.com

Uwe Kleine-König (The Capable Hub) (5):
  pwm: pca9685: Drop unused assignment of acpi_device_id driver data
  pwm: Use named initializers for arrays of acpi_device_id
  pwm: Unify coding style of acpi_device_id arrays
  pwm: Unify coding style of of_device_id arrays
  pwm: lpss-pci: Unify coding style of pci_device_id array

 drivers/pwm/pwm-apple.c           |  2 +-
 drivers/pwm/pwm-argon-fan-hat.c   |  2 +-
 drivers/pwm/pwm-atmel-hlcdc.c     | 15 ++++++---------
 drivers/pwm/pwm-atmel-tcb.c       |  6 +++---
 drivers/pwm/pwm-atmel.c           |  3 +--
 drivers/pwm/pwm-bcm-iproc.c       |  2 +-
 drivers/pwm/pwm-bcm-kona.c        |  2 +-
 drivers/pwm/pwm-bcm2835.c         |  2 +-
 drivers/pwm/pwm-berlin.c          |  2 +-
 drivers/pwm/pwm-brcmstb.c         |  2 +-
 drivers/pwm/pwm-clk.c             |  2 +-
 drivers/pwm/pwm-clps711x.c        |  2 +-
 drivers/pwm/pwm-cros-ec.c         |  2 +-
 drivers/pwm/pwm-hibvt.c           |  2 +-
 drivers/pwm/pwm-imx-tpm.c         |  2 +-
 drivers/pwm/pwm-imx1.c            |  2 +-
 drivers/pwm/pwm-imx27.c           |  2 +-
 drivers/pwm/pwm-ipq.c             |  4 ++--
 drivers/pwm/pwm-jz4740.c          |  2 +-
 drivers/pwm/pwm-loongson.c        |  2 +-
 drivers/pwm/pwm-lp3943.c          |  2 +-
 drivers/pwm/pwm-lpc18xx-sct.c     |  2 +-
 drivers/pwm/pwm-lpc32xx.c         |  2 +-
 drivers/pwm/pwm-lpss-pci.c        |  2 +-
 drivers/pwm/pwm-lpss-platform.c   | 10 +++++-----
 drivers/pwm/pwm-mediatek.c        |  2 +-
 drivers/pwm/pwm-meson.c           |  9 ++++-----
 drivers/pwm/pwm-mtk-disp.c        |  8 ++++----
 drivers/pwm/pwm-mxs.c             |  2 +-
 drivers/pwm/pwm-omap-dmtimer.c    |  4 ++--
 drivers/pwm/pwm-pca9685.c         |  6 +++---
 drivers/pwm/pwm-pxa.c             |  8 ++++----
 drivers/pwm/pwm-raspberrypi-poe.c |  2 +-
 drivers/pwm/pwm-rcar.c            |  4 ++--
 drivers/pwm/pwm-renesas-tpu.c     | 10 +++++-----
 drivers/pwm/pwm-rockchip.c        |  8 ++++----
 drivers/pwm/pwm-rzg2l-gpt.c       |  2 +-
 drivers/pwm/pwm-samsung.c         |  2 +-
 drivers/pwm/pwm-sifive.c          |  2 +-
 drivers/pwm/pwm-sl28cpld.c        |  2 +-
 drivers/pwm/pwm-sophgo-sg2042.c   |  7 +++----
 drivers/pwm/pwm-sprd.c            |  4 ++--
 drivers/pwm/pwm-sti.c             |  2 +-
 drivers/pwm/pwm-stm32-lp.c        |  4 ++--
 drivers/pwm/pwm-stm32.c           |  6 +++---
 drivers/pwm/pwm-sun4i.c           |  2 +-
 drivers/pwm/pwm-sunplus.c         |  4 ++--
 drivers/pwm/pwm-tiecap.c          |  6 +++---
 drivers/pwm/pwm-tiehrpwm.c        |  2 +-
 drivers/pwm/pwm-twl-led.c         |  2 +-
 drivers/pwm/pwm-twl.c             |  2 +-
 drivers/pwm/pwm-visconti.c        |  2 +-
 drivers/pwm/pwm-vt8500.c          |  2 +-
 drivers/pwm/pwm-xilinx.c          |  4 ++--
 54 files changed, 96 insertions(+), 102 deletions(-)


base-commit: 1a4920940ebfd8d907858abd8f8dd09b13752946
prerequisite-patch-id: b423a9d049b4520ef37b40635c95004363ecf692
-- 
2.55.0.11.g153666a7d9bb


