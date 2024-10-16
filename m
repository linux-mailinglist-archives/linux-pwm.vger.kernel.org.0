Return-Path: <linux-pwm+bounces-3683-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 053CC9A0E1B
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 17:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33E691C2247B
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 15:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F5C20E035;
	Wed, 16 Oct 2024 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="lAJ8Llu2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B07220E02E;
	Wed, 16 Oct 2024 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729092372; cv=none; b=O/zhphboR+dVS1Fs0kNrcUCoQGA+2BBvNfKJv1vt0By1KYFppXJ2QFQ8p4I6pxgACoSgn1HMzWODorCf+7UNeeQIM7ZLYQCQuIYselTdgQLty0rzdL4jsIYYcN272+bjiVesqtM/hXKH+ChTK8bY3whh2daPQw6WS+9KyMELEsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729092372; c=relaxed/simple;
	bh=pzNNgDuxImqHyst/YyLSyIA38oXgv7b0NdN2+3YS/yw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NY/27QT9qV4orqAKl23Z8wtVb25klAMgwbBJWnHLwmY69h03vLbYYX1Q9hpkYVtJpw/IFB8bWAG94vU1J3v6vXUiajOBoHLQ9LM5Yx1UHqiS7Pn4U5P5x/4eq8MKZcPFTUpgv3YxzormC5fieeXz/QWZ2WFEguPYRxfAK9nWFt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=lAJ8Llu2; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id C10FD12001D;
	Wed, 16 Oct 2024 18:26:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C10FD12001D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1729092360;
	bh=T3Q1msRaeqxF6VzybefXJBK+HzKQABZ1uZVeBIxYoFo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=lAJ8Llu23qIYlVS/UmkWoFAYtBOyPX3negL50vqIGE3ubb/+uiM+WYKeZiF+GWe61
	 UabP+Dd1WH5CBPUi9PeJneUNhGmukkPtwCJmbQZykAT1x8OfOSEsxV2o1eK3fsuhsy
	 cTb5FustcsfJyaWxgzhFA5nAdsTgqXFX0E1nBmHcQ6E/Z56MKbac2/3/B/9zy9lvOz
	 w2RLO+fAidAuxQPMmAI5f9OlpLtPZbjaI4nV01/eFWquhAfyYklW/Umqh3tRUFjC45
	 wLcycyua/k7TAopaNM7NUi0ZJ+WnpcBCM1arfJB1XHwaREb0WD2AEv8HSrUxp68OM3
	 +HOayN/AukuQw==
Received: from smtp.sberdevices.ru (unknown [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 16 Oct 2024 18:26:00 +0300 (MSK)
From: George Stark <gnstark@salutedevices.com>
To: <u.kleine-koenig@pengutronix.de>, <neil.armstrong@linaro.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <linux-pwm@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>, George Stark <gnstark@salutedevices.com>
Subject: [PATCH v2 0/4] pwm: meson: Support constant and polarity bits
Date: Wed, 16 Oct 2024 18:25:49 +0300
Message-ID: <20241016152553.2321992-1-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188483 [Oct 16 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;lore.kernel.org:7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/10/16 12:29:00
X-KSMG-LinksScanning: Clean, bases: 2024/10/16 12:30:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/16 12:08:00 #26762169
X-KSMG-AntiVirus-Status: Clean, skipped

This patch series add support for amlogic's newer PWM IPs hardware features:
constant and polarity bits.

Using polarity bit for inverting output signal allows to identify inversion
in .get_state() callback which can only rely on data read from registers.

Using constant bit allows to have steady output level when duty cycle is zero or
equal to period. Without this bit there will always be single-clock spikes on output.

Those bits are supported in axg, g12 and newer SoC families like s4, a1 etc.
Tested on g12, a1.

Changes in v2:
  pwm: meson: Support constant and polarity bits
    - drop separate set_constant() and set_polarity() and move register writings
      into enable() and disable()
  pwm: meson: Simplify get_state() callback
    - add new patch to make .get_state() callback consistent. Since I add new
      fields to struct meson_pwm_channel either we should fill back all of them
      from registers or not at all.
  pwm: meson: Use separate device id data for axg and g12
    - add splitting amlogic,meson8-pwm-v2 into amlogic,meson-axg-pwm-v2 and
      amlogic,meson-g12-pwm-v2 with pwm_meson_axg_v2_data for both compatibles.
    - update commit message
    - add tag: Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
  pwm: meson: Enable constant and polarity features for g12, axg, s4
    - add enabling const and polarity to pwm_meson_axg_v2_data
    - add tag: Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
  link to v1: [1]

[1] https://lore.kernel.org/linux-arm-kernel/20241007193203.1753326-4-gnstark@salutedevices.com/T/

George Stark (4):
  pwm: meson: Simplify get_state() callback
  pwm: meson: Support constant and polarity bits
  pwm: meson: Use separate device id data for axg and g12
  pwm: meson: Enable constant and polarity features for g12, axg, s4

 drivers/pwm/pwm-meson.c | 103 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 92 insertions(+), 11 deletions(-)

--
2.25.1


