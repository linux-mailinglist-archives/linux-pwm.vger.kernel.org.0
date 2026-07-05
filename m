Return-Path: <linux-pwm+bounces-9577-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cHYWLEh1SmruDQEAu9opvQ
	(envelope-from <linux-pwm+bounces-9577-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 17:16:24 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF2C70A709
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 17:16:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=iuWetFnh;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9577-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9577-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D82F6300D847
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Jul 2026 15:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30502389DE0;
	Sun,  5 Jul 2026 15:14:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DBB38944D
	for <linux-pwm@vger.kernel.org>; Sun,  5 Jul 2026 15:14:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783264488; cv=none; b=EJS7Tw3QDWxBI2xzULz6+gjd7SdAJxBppdHcmWkHOiVepOLBEWrpi/IvTCI8Rcsd7fpvzZgDCMQQq91zkB1VS8Hb8dWpN1hp49IpCWPxBvqL81S4KjGVYcPO5Pp5LRFgfN/sKhiaouB6IYjg74YsmbGquxtfWUQlpSlfVp7m7PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783264488; c=relaxed/simple;
	bh=Xf/xzFGJi2vaDFB15xp0iGcI3t4qdDyhgsnIwc5oNsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DeF6JMRtfBe4EHTjTOF+bN0GIFx/cFd1o2qv/BeuUfdwdhx2RkfTH7t79gHwaDhS1ZcEjLuIRefn2u2d2rHRGwZnDcv7GbSRaCR5XilOtgMj5BnNQ8DAGdOEsAB+/LXTWc8oZdGZ/peQx7UshsCTbRf5vHkLbzGOf5ZUUvm0wjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=iuWetFnh; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493b77b150aso20045365e9.2
        for <linux-pwm@vger.kernel.org>; Sun, 05 Jul 2026 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783264484; x=1783869284; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6CB0Qn/eLcxkW55Gksdgt2UmNi3HYRow65CVxg+mV6U=;
        b=iuWetFnhXXj5bMy9V7OLx9ulmYm6RG/Ay1yoNxd4srvD6guTArqjWCcORjUX5vma75
         eLGZXVvqpOik4XnikMXwMOpMemL9xD/5ptoCKX285Dhbk13RHqcvQuUB+1pvU1HEDGSt
         xn7n3RDNraEsmfayVaWxPUFbpMJi+Gu3rSf/MFAQTQHROAvb5cXOb7AhkWX2/PlszvGx
         pQhJTf0eYS6nFgruo1zynlCudF8RfiHdDR35smFJAXXdNgjENScJc1iAXziLkBD+P1JM
         XMJlfVQdefkUncyNzo+ox7kXAr6tRjCLwK/5a+u7A5I3d4CKlFzXv2Q56jaKensRlb85
         gXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783264484; x=1783869284;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6CB0Qn/eLcxkW55Gksdgt2UmNi3HYRow65CVxg+mV6U=;
        b=oAvNg85CTkHrAy9TpmAnnMcgmoOqIRNJv2fhP9L/AtDgALRZAkMAF0yjo8u1zBjodx
         HadrJGqjX2SgbxqWdpOIeB98w7EKOf/bHAOEoilPOK7Zt6tH2k77bmpeEgkWDPKIMDiu
         F14ZHwca/uTPLyWgkb5Agw3zj5xlHsC3ndWjyKMBObkbKFnKNQPB6mJlmjNLusmlLADc
         +t6nsAodraCeBIWNNlYX8EJT9MtlxdrKh7gRODXJab3xTKFJ97JsX2zPbb29WaPguFCp
         n83Cuj5m7ZTgJmW9cY1yzy8M1LOEnL6EhCAc+bki9kpNySdk9bb9ZzBFK4x5fpr5Fkls
         qW4Q==
X-Gm-Message-State: AOJu0YzGttdAEnWcXOd8/CvoQKLP7sqpo8nhYCSjB7nXinKPV1amWpr9
	JY/3b/ZopclYuBzDoVk1Q2cNUi3d5or5DARQQtZjKlJGmEcpzPPanAHEVpJsmP0oRjCHkWnLUss
	j64eb
X-Gm-Gg: AfdE7cl3HPV2Kjf2e68a92SYxdmytyWBvTYR+jz9puL3fwMvOlom439XK+sLMYZeihi
	sDw9LnOD68Ds2IP+w4JzHR1cZgV1GG/j8gckrVy25Qqod+gm5fsvPArI63ppCfDcr9/w4N6+e4Z
	0Y8R2+BQX0+HMq8WcxxIlmHhlO9xlckC3RlBhj6qmYjuxVvVAZtqtLf4OcmWa24O2FmfoxN+Hw7
	Aagn+Fi7qkVjHLCvGLfVjnMZ7Na/PicwBy+PMxz9RWAW8qapiOOK6C6uge5mfmCof/Xd0Cw4EB3
	QkffBKAGGcNPmVguZBjSNL+YYDXjSVftaX6bpQCf228AotdfmodSOEUzf8JTZFgJQ4T854TP9jj
	vwyDRkpLE/kB6cVpLdXNEQdL54lypEjlX0SY1o0JjahD6BVCh2xUeXsUpH1ZJ1UyV6Qc3in++NK
	KjETTF0H48xHuL/jPKyQ==
X-Received: by 2002:a05:600c:4686:b0:493:c42c:7e88 with SMTP id 5b1f17b1804b1-493d11fecddmr76405695e9.34.1783264482603;
        Sun, 05 Jul 2026 08:14:42 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47a9de1d8f1sm16472176f8f.3.2026.07.05.08.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 08:14:42 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Sven Peter <sven@kernel.org>,
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
	linux-kernel@vger.kernel.org,
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
Subject: [PATCH v1 4/5] pwm: Unify coding style of of_device_id arrays
Date: Sun,  5 Jul 2026 17:14:16 +0200
Message-ID:  <20de6cd60c2938aad2d21397b92742849418ab1b.1783263835.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1783263835.git.ukleinek@kernel.org>
References: <cover.1783263835.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=29840; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Xf/xzFGJi2vaDFB15xp0iGcI3t4qdDyhgsnIwc5oNsQ=; b=owGbwMvMwMXY3/A7olbonx/jabUkhiyvknOB2kYL6roFdBK/eHqKL7p1I3PaVY2eXTsi/5g0z WGZdlmxk9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJhNqw/+He8vXPeuY2lotR h5cfl7Sc9aCEu9Pm+vHH2h8X8daFHV1kmrAp7dsej06d/57B+qXVLB53pm6UEfl+/UT/mR9/vF7 VOGX9iP409RLTJufFQRWvxG8m9Ld8nNliFvE/uf1ee/L8Bz/f1EgsdGsr0t8oY27z5vyi4JuiGg clg7W6reJZJONvWZo80H/Z47OHtfKm7rIgjRP7+esrX01OLvde/Khg29m9tX/qU3f+bz+oLz3f3 mJF/f4DGn3dlb1vm+O6js5o9gheqpx92LhzQWnC0YNR3lUG+W9LTna2OC1J12WMLHfrWqHbalIz X097pgqP/mSeUvUnMw3b5d0Vbxc/v6QhWCXXkirMIn8PAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9577-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-pwm@vger.kernel.org,m:sven@kernel.org,m:j@jannau.net,m:neal@gompa.dev,m:nicolas.ferre@microchip.com,m:alexandre.belloni@bootlin.com,m:claudiu.beznea@tuxon.dev,m:rjui@broadcom.com,m:sbranden@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:florian.fainelli@broadcom.com,m:bleung@chromium.org,m:groeck@chromium.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:kernel@pengutronix.de,m:festevam@gmail.com,m:paul@crapouillou.net,m:vz@mleia.com,m:piotr.wojtaszczyk@timesys.com,m:neil.armstrong@linaro.org,m:khilman@baylibre.com,m:jbrunet@baylibre.com,m:martin.blumenstingl@googlemail.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:heiko@sntech.de,m:krzk@kernel.org,m:peter.griffin@linaro.org,m:alim.akhtar@samsung.com,m:pjw@kernel.org,m:samuel.holland@sifive.com,m:mwalle@kernel.org,m:chen.wang@linux.dev,m:inochiama@gmail.com,m:orsonzhai@gmail.com,m:baolin.wang@linux.alibaba.com,m:zhang
 .lyra@gmail.com,m:fabrice.gasnier@foss.st.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:hammerh0314@gmail.com,m:nobuhiro.iwamatsu.x90@mail.toshiba,m:alchark@gmail.com,m:sean.anderson@linux.dev,m:michal.simek@amd.com,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-rpi-kernel@lists.infradead.org,m:chrome-platform@lists.linux.dev,m:imx@lists.linux.dev,m:linux-mips@vger.kernel.org,m:linux-amlogic@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-renesas-soc@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-samsung-soc@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:sophgo@lists.linux.dev,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-sunxi@lists.linux.dev,m:martinblumenstingl@gmail.com,m:matthiasbgg@gmail.com,m:geert@glider.be,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[baylibre.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,jannau.net,gompa.dev,microchip.com,bootlin.com,tuxon.dev,broadcom.com,chromium.org,nxp.com,pengutronix.de,gmail.com,crapouillou.net,mleia.com,timesys.com,linaro.org,baylibre.com,googlemail.com,collabora.com,glider.be,sntech.de,samsung.com,sifive.com,linux.dev,linux.alibaba.com,foss.st.com,mail.toshiba,amd.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,st-md-mailman.stormreply.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	RCPT_COUNT_GT_50(0.00)[66];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:from_mime,baylibre.com:email,baylibre.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1AF2C70A709

 - Use a single space in a of_device_id array terminator; A single space
   after the opening { and before the closing } in non-empty
   initializers;
 - No comma after an array terminator;
 - Also no trailing comma after a named initializer iff the
   closing } is on the same line;

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
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
 drivers/pwm/pwm-lp3943.c          |  2 +-
 drivers/pwm/pwm-lpc18xx-sct.c     |  2 +-
 drivers/pwm/pwm-lpc32xx.c         |  2 +-
 drivers/pwm/pwm-mediatek.c        |  2 +-
 drivers/pwm/pwm-meson.c           |  9 ++++-----
 drivers/pwm/pwm-mtk-disp.c        |  8 ++++----
 drivers/pwm/pwm-mxs.c             |  2 +-
 drivers/pwm/pwm-omap-dmtimer.c    |  4 ++--
 drivers/pwm/pwm-pca9685.c         |  2 +-
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
 51 files changed, 87 insertions(+), 93 deletions(-)

diff --git a/drivers/pwm/pwm-apple.c b/drivers/pwm/pwm-apple.c
index 6e58aca2f13c..3c8ae739ffdb 100644
--- a/drivers/pwm/pwm-apple.c
+++ b/drivers/pwm/pwm-apple.c
@@ -142,7 +142,7 @@ static int apple_pwm_probe(struct platform_device *pdev)
 
 static const struct of_device_id apple_pwm_of_match[] = {
 	{ .compatible = "apple,s5l-fpwm" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, apple_pwm_of_match);
 
diff --git a/drivers/pwm/pwm-argon-fan-hat.c b/drivers/pwm/pwm-argon-fan-hat.c
index 2c59bd142d40..b480663e87d5 100644
--- a/drivers/pwm/pwm-argon-fan-hat.c
+++ b/drivers/pwm/pwm-argon-fan-hat.c
@@ -89,7 +89,7 @@ static int argon_fan_hat_i2c_probe(struct i2c_client *i2c)
 
 static const struct of_device_id argon_fan_hat_dt_ids[] = {
 	{ .compatible = "argon40,fan-hat" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, argon_fan_hat_dt_ids);
 
diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index 387a0d1fa4f2..1ba2c9a049b9 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -217,23 +217,20 @@ static const struct of_device_id atmel_hlcdc_dt_ids[] = {
 		.compatible = "atmel,at91sam9n12-hlcdc",
 		/* 9n12 has same errata as 9x5 HLCDC PWM */
 		.data = &atmel_hlcdc_pwm_at91sam9x5_errata,
-	},
-	{
+	}, {
 		.compatible = "atmel,at91sam9x5-hlcdc",
 		.data = &atmel_hlcdc_pwm_at91sam9x5_errata,
-	},
-	{
+	}, {
 		.compatible = "atmel,sama5d2-hlcdc",
-	},
-	{
+	}, {
 		.compatible = "atmel,sama5d3-hlcdc",
 		.data = &atmel_hlcdc_pwm_sama5d3_errata,
-	},
-	{
+	}, {
 		.compatible = "atmel,sama5d4-hlcdc",
 		.data = &atmel_hlcdc_pwm_sama5d3_errata,
+	}, {
+		.compatible = "microchip,sam9x60-hlcdc",
 	},
-	{	.compatible = "microchip,sam9x60-hlcdc", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, atmel_hlcdc_dt_ids);
diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index a765ef279b51..f74a42d75b81 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -374,9 +374,9 @@ static struct atmel_tcb_config tcb_sama5d2_config = {
 };
 
 static const struct of_device_id atmel_tcb_of_match[] = {
-	{ .compatible = "atmel,at91rm9200-tcb", .data = &tcb_rm9200_config, },
-	{ .compatible = "atmel,at91sam9x5-tcb", .data = &tcb_sam9x5_config, },
-	{ .compatible = "atmel,sama5d2-tcb", .data = &tcb_sama5d2_config, },
+	{ .compatible = "atmel,at91rm9200-tcb", .data = &tcb_rm9200_config },
+	{ .compatible = "atmel,at91sam9x5-tcb", .data = &tcb_sam9x5_config },
+	{ .compatible = "atmel,sama5d2-tcb", .data = &tcb_sama5d2_config },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 06d22d0f7b26..86918523d821 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -441,9 +441,8 @@ static const struct of_device_id atmel_pwm_dt_ids[] = {
 	}, {
 		.compatible = "microchip,sam9x60-pwm",
 		.data = &mchp_sam9x60_pwm_data,
-	}, {
-		/* sentinel */
 	},
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
 
diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
index f4c9f10e490e..dc1e792b1e08 100644
--- a/drivers/pwm/pwm-bcm-iproc.c
+++ b/drivers/pwm/pwm-bcm-iproc.c
@@ -230,7 +230,7 @@ static int iproc_pwmc_probe(struct platform_device *pdev)
 
 static const struct of_device_id bcm_iproc_pwmc_dt[] = {
 	{ .compatible = "brcm,iproc-pwm" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, bcm_iproc_pwmc_dt);
 
diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 022c078aae84..ecfa3e3707f4 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -319,7 +319,7 @@ static int kona_pwmc_probe(struct platform_device *pdev)
 
 static const struct of_device_id bcm_kona_pwmc_dt[] = {
 	{ .compatible = "brcm,kona-pwm" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, bcm_kona_pwmc_dt);
 
diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 532903da521f..a4fbf9cfc6f7 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -165,7 +165,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(bcm2835_pwm_pm_ops, bcm2835_pwm_suspend,
 				bcm2835_pwm_resume);
 
 static const struct of_device_id bcm2835_pwm_of_match[] = {
-	{ .compatible = "brcm,bcm2835-pwm", },
+	{ .compatible = "brcm,bcm2835-pwm" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, bcm2835_pwm_of_match);
diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index 858d36991374..5db4d41a7442 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -191,7 +191,7 @@ static const struct pwm_ops berlin_pwm_ops = {
 
 static const struct of_device_id berlin_pwm_match[] = {
 	{ .compatible = "marvell,berlin-pwm" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, berlin_pwm_match);
 
diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
index 82d27d07ba91..790ef7ffbbe5 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -222,7 +222,7 @@ static const struct pwm_ops brcmstb_pwm_ops = {
 };
 
 static const struct of_device_id brcmstb_pwm_of_match[] = {
-	{ .compatible = "brcm,bcm7038-pwm", },
+	{ .compatible = "brcm,bcm7038-pwm" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, brcmstb_pwm_of_match);
diff --git a/drivers/pwm/pwm-clk.c b/drivers/pwm/pwm-clk.c
index f8f5af57acba..1907f2f10e5c 100644
--- a/drivers/pwm/pwm-clk.c
+++ b/drivers/pwm/pwm-clk.c
@@ -119,7 +119,7 @@ static void pwm_clk_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id pwm_clk_dt_ids[] = {
-	{ .compatible = "clk-pwm", },
+	{ .compatible = "clk-pwm" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, pwm_clk_dt_ids);
diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index 2c92ce754872..1ce12ee0329b 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -91,7 +91,7 @@ static int clps711x_pwm_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id clps711x_pwm_dt_ids[] = {
-	{ .compatible = "cirrus,ep7209-pwm", },
+	{ .compatible = "cirrus,ep7209-pwm" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, clps711x_pwm_dt_ids);
diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 67cfa17f58e0..08a24a45c76d 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -267,7 +267,7 @@ static int cros_ec_pwm_probe(struct platform_device *pdev)
 static const struct of_device_id cros_ec_pwm_of_match[] = {
 	{ .compatible = "google,cros-ec-pwm" },
 	{ .compatible = "google,cros-ec-pwm-type" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, cros_ec_pwm_of_match);
 #endif
diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index e02ee6383dbc..29ad8d0b5536 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -266,7 +266,7 @@ static const struct of_device_id hibvt_pwm_of_match[] = {
 	  .data = &hi3559v100_shub_soc_info },
 	{ .compatible = "hisilicon,hi3559v100-pwm",
 	  .data = &hi3559v100_soc_info },
-	{  }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, hibvt_pwm_of_match);
 
diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index 80fdb3303400..c20753a36d6d 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -442,7 +442,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(imx_tpm_pwm_pm,
 				pwm_imx_tpm_suspend, pwm_imx_tpm_resume);
 
 static const struct of_device_id imx_tpm_pwm_dt_ids[] = {
-	{ .compatible = "fsl,imx7ulp-pwm", },
+	{ .compatible = "fsl,imx7ulp-pwm" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_tpm_pwm_dt_ids);
diff --git a/drivers/pwm/pwm-imx1.c b/drivers/pwm/pwm-imx1.c
index d5535d208005..075d46180dff 100644
--- a/drivers/pwm/pwm-imx1.c
+++ b/drivers/pwm/pwm-imx1.c
@@ -151,7 +151,7 @@ static const struct pwm_ops pwm_imx1_ops = {
 };
 
 static const struct of_device_id pwm_imx1_dt_ids[] = {
-	{ .compatible = "fsl,imx1-pwm", },
+	{ .compatible = "fsl,imx1-pwm" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, pwm_imx1_dt_ids);
diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index c8b801fcb525..7c1ad15008d2 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -378,7 +378,7 @@ static const struct pwm_ops pwm_imx27_ops = {
 };
 
 static const struct of_device_id pwm_imx27_dt_ids[] = {
-	{ .compatible = "fsl,imx27-pwm", },
+	{ .compatible = "fsl,imx27-pwm" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, pwm_imx27_dt_ids);
diff --git a/drivers/pwm/pwm-ipq.c b/drivers/pwm/pwm-ipq.c
index c53373948136..6b7aec566f7e 100644
--- a/drivers/pwm/pwm-ipq.c
+++ b/drivers/pwm/pwm-ipq.c
@@ -245,8 +245,8 @@ static int ipq_pwm_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id pwm_ipq_dt_match[] = {
-	{ .compatible = "qcom,ipq6018-pwm", },
-	{}
+	{ .compatible = "qcom,ipq6018-pwm" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, pwm_ipq_dt_match);
 
diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index e0b5966fc7fe..0db1474c7c8c 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -261,7 +261,7 @@ static const struct of_device_id jz4740_pwm_dt_ids[] = {
 	{ .compatible = "ingenic,jz4740-pwm", .data = &jz4740_soc_info },
 	{ .compatible = "ingenic,jz4725b-pwm", .data = &jz4725b_soc_info },
 	{ .compatible = "ingenic,x1000-pwm", .data = &x1000_soc_info },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, jz4740_pwm_dt_ids);
 
diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
index 90b0733c00c1..10537e74be28 100644
--- a/drivers/pwm/pwm-lp3943.c
+++ b/drivers/pwm/pwm-lp3943.c
@@ -296,7 +296,7 @@ static int lp3943_pwm_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_OF
 static const struct of_device_id lp3943_pwm_of_match[] = {
-	{ .compatible = "ti,lp3943-pwm", },
+	{ .compatible = "ti,lp3943-pwm" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, lp3943_pwm_of_match);
diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 1e614b2a0227..4a1950635850 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -330,7 +330,7 @@ static const struct pwm_ops lpc18xx_pwm_ops = {
 
 static const struct of_device_id lpc18xx_pwm_of_match[] = {
 	{ .compatible = "nxp,lpc1850-sct-pwm" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, lpc18xx_pwm_of_match);
 
diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
index c748537e57d1..19ec53648f40 100644
--- a/drivers/pwm/pwm-lpc32xx.c
+++ b/drivers/pwm/pwm-lpc32xx.c
@@ -155,7 +155,7 @@ static int lpc32xx_pwm_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id lpc32xx_pwm_dt_ids[] = {
-	{ .compatible = "nxp,lpc3220-pwm", },
+	{ .compatible = "nxp,lpc3220-pwm" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, lpc32xx_pwm_dt_ids);
diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 992137a27750..0bb49be657b7 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -627,7 +627,7 @@ static const struct of_device_id pwm_mediatek_of_match[] = {
 	{ .compatible = "mediatek,mt8183-pwm", .data = &mt8183_pwm_data },
 	{ .compatible = "mediatek,mt8365-pwm", .data = &mt8365_pwm_data },
 	{ .compatible = "mediatek,mt8516-pwm", .data = &mt8516_pwm_data },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, pwm_mediatek_of_match);
 
diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 8c6bf3d49753..20e6cd07127c 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -596,15 +596,14 @@ static const struct of_device_id meson_pwm_matches[] = {
 	{
 		.compatible = "amlogic,meson8-pwm-v2",
 		.data = &pwm_meson8_v2_data
-	},
-	{
+	}, {
 		.compatible = "amlogic,meson-axg-pwm-v2",
 		.data = &pwm_meson_axg_v2_data
-	},
-	{
+	}, {
 		.compatible = "amlogic,meson-g12-pwm-v2",
 		.data = &pwm_meson_axg_v2_data
 	},
+
 	/* The following compatibles are obsolete */
 	{
 		.compatible = "amlogic,meson8b-pwm",
@@ -642,7 +641,7 @@ static const struct of_device_id meson_pwm_matches[] = {
 		.compatible = "amlogic,meson-s4-pwm",
 		.data = &pwm_s4_data
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, meson_pwm_matches);
 
diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index bafd6b6195f6..b5409e15dac8 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -295,10 +295,10 @@ static const struct mtk_pwm_data mt8183_pwm_data = {
 };
 
 static const struct of_device_id mtk_disp_pwm_of_match[] = {
-	{ .compatible = "mediatek,mt2701-disp-pwm", .data = &mt2701_pwm_data},
-	{ .compatible = "mediatek,mt6595-disp-pwm", .data = &mt8173_pwm_data},
-	{ .compatible = "mediatek,mt8173-disp-pwm", .data = &mt8173_pwm_data},
-	{ .compatible = "mediatek,mt8183-disp-pwm", .data = &mt8183_pwm_data},
+	{ .compatible = "mediatek,mt2701-disp-pwm", .data = &mt2701_pwm_data },
+	{ .compatible = "mediatek,mt6595-disp-pwm", .data = &mt8173_pwm_data },
+	{ .compatible = "mediatek,mt8173-disp-pwm", .data = &mt8173_pwm_data },
+	{ .compatible = "mediatek,mt8183-disp-pwm", .data = &mt8183_pwm_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mtk_disp_pwm_of_match);
diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index 8cad214b1c29..e1a3df6549fc 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -163,7 +163,7 @@ static int mxs_pwm_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id mxs_pwm_dt_ids[] = {
-	{ .compatible = "fsl,imx23-pwm", },
+	{ .compatible = "fsl,imx23-pwm" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mxs_pwm_dt_ids);
diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 1858a77401f8..51830a87275c 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -444,8 +444,8 @@ static void pwm_omap_dmtimer_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id pwm_omap_dmtimer_of_match[] = {
-	{.compatible = "ti,omap-dmtimer-pwm"},
-	{}
+	{ .compatible = "ti,omap-dmtimer-pwm" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, pwm_omap_dmtimer_of_match);
 
diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 8babd29f161c..a2792b803643 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -550,7 +550,7 @@ static const struct acpi_device_id pca9685_acpi_ids[] = {
 MODULE_DEVICE_TABLE(acpi, pca9685_acpi_ids);
 
 static const struct of_device_id pca9685_dt_ids[] = {
-	{ .compatible = "nxp,pca9685-pwm", },
+	{ .compatible = "nxp,pca9685-pwm" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, pca9685_dt_ids);
diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 157735d0d054..07f5e09f1b1a 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -144,10 +144,10 @@ static const struct pwm_ops pxa_pwm_ops = {
  * supported identically.
  */
 static const struct of_device_id pwm_of_match[] = {
-	{ .compatible = "marvell,pxa250-pwm", .data = &pwm_id_table[0]},
-	{ .compatible = "marvell,pxa270-pwm", .data = &pwm_id_table[0]},
-	{ .compatible = "marvell,pxa168-pwm", .data = &pwm_id_table[0]},
-	{ .compatible = "marvell,pxa910-pwm", .data = &pwm_id_table[0]},
+	{ .compatible = "marvell,pxa250-pwm", .data = &pwm_id_table[0] },
+	{ .compatible = "marvell,pxa270-pwm", .data = &pwm_id_table[0] },
+	{ .compatible = "marvell,pxa168-pwm", .data = &pwm_id_table[0] },
+	{ .compatible = "marvell,pxa910-pwm", .data = &pwm_id_table[0] },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pwm_of_match);
diff --git a/drivers/pwm/pwm-raspberrypi-poe.c b/drivers/pwm/pwm-raspberrypi-poe.c
index 8921e7ea2cea..7cea6561c730 100644
--- a/drivers/pwm/pwm-raspberrypi-poe.c
+++ b/drivers/pwm/pwm-raspberrypi-poe.c
@@ -177,7 +177,7 @@ static int raspberrypi_pwm_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id raspberrypi_pwm_of_match[] = {
-	{ .compatible = "raspberrypi,firmware-poe-pwm", },
+	{ .compatible = "raspberrypi,firmware-poe-pwm" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, raspberrypi_pwm_of_match);
diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 578dbdd2d5a7..1733cd700693 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -248,8 +248,8 @@ static void rcar_pwm_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id rcar_pwm_of_table[] = {
-	{ .compatible = "renesas,pwm-rcar", },
-	{ },
+	{ .compatible = "renesas,pwm-rcar" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, rcar_pwm_of_table);
 
diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 2196080b4177..140fd0bcb93f 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -479,11 +479,11 @@ static int tpu_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_OF
 static const struct of_device_id tpu_of_table[] = {
-	{ .compatible = "renesas,tpu-r8a73a4", },
-	{ .compatible = "renesas,tpu-r8a7740", },
-	{ .compatible = "renesas,tpu-r8a7790", },
-	{ .compatible = "renesas,tpu", },
-	{ },
+	{ .compatible = "renesas,tpu-r8a73a4" },
+	{ .compatible = "renesas,tpu-r8a7740" },
+	{ .compatible = "renesas,tpu-r8a7790" },
+	{ .compatible = "renesas,tpu" },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, tpu_of_table);
diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 67b85bdb491b..050ca8aad0ca 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -292,10 +292,10 @@ static const struct rockchip_pwm_data pwm_data_v3 = {
 };
 
 static const struct of_device_id rockchip_pwm_dt_ids[] = {
-	{ .compatible = "rockchip,rk2928-pwm", .data = &pwm_data_v1},
-	{ .compatible = "rockchip,rk3288-pwm", .data = &pwm_data_v2},
-	{ .compatible = "rockchip,vop-pwm", .data = &pwm_data_vop},
-	{ .compatible = "rockchip,rk3328-pwm", .data = &pwm_data_v3},
+	{ .compatible = "rockchip,rk2928-pwm", .data = &pwm_data_v1 },
+	{ .compatible = "rockchip,rk3288-pwm", .data = &pwm_data_v2 },
+	{ .compatible = "rockchip,vop-pwm", .data = &pwm_data_vop },
+	{ .compatible = "rockchip,rk3328-pwm", .data = &pwm_data_v3 },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rockchip_pwm_dt_ids);
diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index dfa1d11a48a8..ac8399b96ad1 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -437,7 +437,7 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id rzg2l_gpt_of_table[] = {
-	{ .compatible = "renesas,rzg2l-gpt", },
+	{ .compatible = "renesas,rzg2l-gpt" },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzg2l_gpt_of_table);
diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 951b38ff5f8e..331e81f1594a 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -501,7 +501,7 @@ static const struct of_device_id samsung_pwm_matches[] = {
 	{ .compatible = "samsung,s5p6440-pwm", .data = &s5p64x0_variant },
 	{ .compatible = "samsung,s5pc100-pwm", .data = &s5pc100_variant },
 	{ .compatible = "samsung,exynos4210-pwm", .data = &s5p64x0_variant },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, samsung_pwm_matches);
 
diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 4a07315b0744..d5000ea9084a 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -356,7 +356,7 @@ static void pwm_sifive_remove(struct platform_device *dev)
 
 static const struct of_device_id pwm_sifive_of_match[] = {
 	{ .compatible = "sifive,pwm0" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, pwm_sifive_of_match);
 
diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
index 934378d6a002..ba6bec0b9289 100644
--- a/drivers/pwm/pwm-sl28cpld.c
+++ b/drivers/pwm/pwm-sl28cpld.c
@@ -245,7 +245,7 @@ static int sl28cpld_pwm_probe(struct platform_device *pdev)
 
 static const struct of_device_id sl28cpld_pwm_of_match[] = {
 	{ .compatible = "kontron,sl28cpld-pwm" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, sl28cpld_pwm_of_match);
 
diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg2042.c
index 7d07b0ca7d29..0b6461172e6a 100644
--- a/drivers/pwm/pwm-sophgo-sg2042.c
+++ b/drivers/pwm/pwm-sophgo-sg2042.c
@@ -225,11 +225,10 @@ static const struct sg2042_chip_data sg2044_chip_data = {
 static const struct of_device_id sg2042_pwm_ids[] = {
 	{
 		.compatible = "sophgo,sg2042-pwm",
-		.data = &sg2042_chip_data
-	},
-	{
+		.data = &sg2042_chip_data,
+	}, {
 		.compatible = "sophgo,sg2044-pwm",
-		.data = &sg2044_chip_data
+		.data = &sg2044_chip_data,
 	},
 	{ }
 };
diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
index 4c76ca5e4cdd..88928f9e7557 100644
--- a/drivers/pwm/pwm-sprd.c
+++ b/drivers/pwm/pwm-sprd.c
@@ -277,8 +277,8 @@ static int sprd_pwm_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id sprd_pwm_of_match[] = {
-	{ .compatible = "sprd,ums512-pwm", },
-	{ },
+	{ .compatible = "sprd,ums512-pwm" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, sprd_pwm_of_match);
 
diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 3b702b8f0c7f..e5c3cf594571 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -625,7 +625,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id sti_pwm_of_match[] = {
-	{ .compatible = "st,sti-pwm", },
+	{ .compatible = "st,sti-pwm" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sti_pwm_of_match);
diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 4789eafb8bac..2aa88f4985f5 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -412,8 +412,8 @@ static DEFINE_SIMPLE_DEV_PM_OPS(stm32_pwm_lp_pm_ops, stm32_pwm_lp_suspend,
 				stm32_pwm_lp_resume);
 
 static const struct of_device_id stm32_pwm_lp_of_match[] = {
-	{ .compatible = "st,stm32-pwm-lp", },
-	{},
+	{ .compatible = "st,stm32-pwm-lp" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, stm32_pwm_lp_of_match);
 
diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index c708e4a7ad70..ea5a51a2800f 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -918,9 +918,9 @@ static int stm32_pwm_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(stm32_pwm_pm_ops, stm32_pwm_suspend, stm32_pwm_resume);
 
 static const struct of_device_id stm32_pwm_of_match[] = {
-	{ .compatible = "st,stm32-pwm",	},
-	{ .compatible = "st,stm32mp25-pwm", },
-	{ /* end node */ },
+	{ .compatible = "st,stm32-pwm" },
+	{ .compatible = "st,stm32mp25-pwm" },
+	{ /* end node */ }
 };
 MODULE_DEVICE_TABLE(of, stm32_pwm_of_match);
 
diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 6c5591ca868b..0752152b1470 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -369,7 +369,7 @@ static const struct of_device_id sun4i_pwm_dt_ids[] = {
 		.data = &sun50i_h6_pwm_data,
 	}, {
 		/* sentinel */
-	},
+	}
 };
 MODULE_DEVICE_TABLE(of, sun4i_pwm_dt_ids);
 
diff --git a/drivers/pwm/pwm-sunplus.c b/drivers/pwm/pwm-sunplus.c
index b342b843247b..b578f3f1a3a3 100644
--- a/drivers/pwm/pwm-sunplus.c
+++ b/drivers/pwm/pwm-sunplus.c
@@ -214,8 +214,8 @@ static int sunplus_pwm_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id sunplus_pwm_of_match[] = {
-	{ .compatible = "sunplus,sp7021-pwm", },
-	{}
+	{ .compatible = "sunplus,sp7021-pwm" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, sunplus_pwm_of_match);
 
diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index 67cc5e8bdb0e..3751737ead43 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -211,9 +211,9 @@ static const struct pwm_ops ecap_pwm_ops = {
 };
 
 static const struct of_device_id ecap_of_match[] = {
-	{ .compatible	= "ti,am3352-ecap" },
-	{ .compatible	= "ti,am33xx-ecap" },
-	{},
+	{ .compatible = "ti,am3352-ecap" },
+	{ .compatible = "ti,am33xx-ecap" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ecap_of_match);
 
diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 2533c95b0ba9..3a53489f0b98 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -407,7 +407,7 @@ static const struct pwm_ops ehrpwm_pwm_ops = {
 static const struct of_device_id ehrpwm_of_match[] = {
 	{ .compatible = "ti,am3352-ehrpwm" },
 	{ .compatible = "ti,am33xx-ehrpwm" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ehrpwm_of_match);
 
diff --git a/drivers/pwm/pwm-twl-led.c b/drivers/pwm/pwm-twl-led.c
index a555cc3be4b3..e1b6871af81e 100644
--- a/drivers/pwm/pwm-twl-led.c
+++ b/drivers/pwm/pwm-twl-led.c
@@ -338,7 +338,7 @@ static int twl_pwmled_probe(struct platform_device *pdev)
 static const struct of_device_id twl_pwmled_of_match[] = {
 	{ .compatible = "ti,twl4030-pwmled" },
 	{ .compatible = "ti,twl6030-pwmled" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, twl_pwmled_of_match);
 #endif
diff --git a/drivers/pwm/pwm-twl.c b/drivers/pwm/pwm-twl.c
index 8f981ffff4b4..99c1caf4f19c 100644
--- a/drivers/pwm/pwm-twl.c
+++ b/drivers/pwm/pwm-twl.c
@@ -362,7 +362,7 @@ static int twl_pwm_probe(struct platform_device *pdev)
 static const struct of_device_id twl_pwm_of_match[] = {
 	{ .compatible = "ti,twl4030-pwm" },
 	{ .compatible = "ti,twl6030-pwm" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, twl_pwm_of_match);
 #endif
diff --git a/drivers/pwm/pwm-visconti.c b/drivers/pwm/pwm-visconti.c
index 28fae4979e3f..830aef483bd0 100644
--- a/drivers/pwm/pwm-visconti.c
+++ b/drivers/pwm/pwm-visconti.c
@@ -156,7 +156,7 @@ static int visconti_pwm_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id visconti_pwm_of_match[] = {
-	{ .compatible = "toshiba,visconti-pwm", },
+	{ .compatible = "toshiba,visconti-pwm" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, visconti_pwm_of_match);
diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 016c82d65527..3f2c8031a626 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -227,7 +227,7 @@ static const struct pwm_ops vt8500_pwm_ops = {
 };
 
 static const struct of_device_id vt8500_pwm_dt_ids[] = {
-	{ .compatible = "via,vt8500-pwm", },
+	{ .compatible = "via,vt8500-pwm" },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, vt8500_pwm_dt_ids);
diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
index 52c241982807..fa2d10e658dd 100644
--- a/drivers/pwm/pwm-xilinx.c
+++ b/drivers/pwm/pwm-xilinx.c
@@ -281,8 +281,8 @@ static int xilinx_pwm_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id xilinx_pwm_of_match[] = {
-	{ .compatible = "xlnx,xps-timer-1.00.a", },
-	{},
+	{ .compatible = "xlnx,xps-timer-1.00.a" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, xilinx_pwm_of_match);
 
-- 
2.55.0.11.g153666a7d9bb


