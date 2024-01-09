Return-Path: <linux-pwm+bounces-705-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFBF828EEE
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jan 2024 22:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958061C21524
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jan 2024 21:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E043DBA1;
	Tue,  9 Jan 2024 21:34:49 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA15C3DB88
	for <linux-pwm@vger.kernel.org>; Tue,  9 Jan 2024 21:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNJkD-0006cn-6D; Tue, 09 Jan 2024 22:34:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNJkA-001Z26-NU; Tue, 09 Jan 2024 22:34:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNJkA-00667o-1u;
	Tue, 09 Jan 2024 22:34:42 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Robert Foss <rfoss@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-pwm@vger.kernel.org,
	kernel@pengutronix.de,
	Douglas Anderson <dianders@chromium.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Alexander Shiyan <shc_work@mail.ru>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev
Subject: [PATCH 0/5] pwm: Some improvements around .of_xlate()
Date: Tue,  9 Jan 2024 22:34:30 +0100
Message-ID: <cover.1704835845.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=961; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=k1tl0KN37p2K0b7qOKWEkrmyn1QBL1dkj6B3e6BITYw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlnbvoRqc5mrbM96UdzaOUAM8/Bh4d2soUH4R0F +5CaT1CHf+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZZ276AAKCRCPgPtYfRL+ TqH1B/4m/xi6nYjDB7Gp39Jvktgrrknz/As6PcQoHQGpYZi5Co5EdfxGQZEeE7pR6e3m0KZXnMV VuWYIf6vFJyXJP+4UnLeR959pZVbzc+ASACr9/oVXbAnsYgzKL6k50bBUocf6WeHs3yBwCGq8K9 9IeoAV4hJseLCg62vusEiDP+ujUf9bwf1arXMbzGArZtv5s5bFHETtk+qK7196yxvQjIZd+QWe3 2+5ytecGvpxw49V1hm5Fv0Bcomzu1AMEIe++KRcjQda1/fW7+ofA80bMwELNEFJ6doZTWXKg2mO cXjku5eSkxvbAY2Dah/O1hNJz9D5QtFx5hnYtWSG6mE2ZHPE
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Hello,

the first patch is a fix for an out-of-bounds access and so should
probably go in quickly. The other changes are merge window material.

Best regards
Uwe

Uwe Kleine-König (5):
  pwm: Fix out-of-bounds access in of_pwm_single_xlate()
  pwm: Drop useless member .of_pwm_n_cells of struct pwm_chip
  pwm: Let the of_xlate callbacks accept references without period
  pwm: clps711x: Drop custom .of_xlate() callback
  pwm: Drop duplicate check against chip->npwm in
    of_pwm_xlate_with_flags()

 drivers/gpu/drm/bridge/ti-sn65dsi86.c |  1 -
 drivers/pwm/core.c                    | 45 +++++++--------------------
 drivers/pwm/pwm-clps711x.c            | 11 -------
 drivers/pwm/pwm-cros-ec.c             |  1 -
 drivers/pwm/pwm-pxa.c                 |  4 +--
 include/linux/pwm.h                   |  2 --
 6 files changed, 13 insertions(+), 51 deletions(-)


base-commit: d73f444d06fb8a42a5c0623453f3ea1fe9880229
-- 
2.43.0


