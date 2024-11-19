Return-Path: <linux-pwm+bounces-4105-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C53D9D2655
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Nov 2024 14:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D881DB2CF03
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Nov 2024 12:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303C41CC890;
	Tue, 19 Nov 2024 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="otr+phbu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EFA1C4A0C;
	Tue, 19 Nov 2024 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732020811; cv=none; b=uRWjbRtY94ZM+6SkoVSxxzndy76mxAPtT7bKLoEdgWAaI+nsVV+OdHd1yMvejppRNdhi9LjO9dudRmeqL/ZBq52KTy+graalculIql9IGohLA9xxxpCOmQJj40xeXKuiUc4ATeO7qGeQ9qdUi0SNDz/gnOlURkswV93NvNFlg9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732020811; c=relaxed/simple;
	bh=5/iGMOq4lvLMFfOAEAyodIwI6eFL8Od3RLD9Y4lz2z4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wm5rzHNUe185mZgteXbgoj1HKDc0N8RjlXoq0V+sCUXIDX4tzHSGyIJJgAveJvuLYIfD5iSqxkOYuDvwhwqIaI9mPWg3pGLQOdHU171lxYY7pFk4z+Fjo8rj3UjNsqbdVkLgdvNwVgLV9uk+M398XWD1p5O9ASO9pccopxw5QnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=otr+phbu; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id BC352100005;
	Tue, 19 Nov 2024 15:53:25 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru BC352100005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1732020805;
	bh=WLMqgYAx8jrAH0NGtJJdr/WAytRnlNbxc+XJ13Kxixw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=otr+phbuxnZgxzhuPNw8Yn5zEK7ExbKETyvkv9/uME+p4txvy5tBOT97ScqSjaY5N
	 FfYu1sAl/Owu8xbp2Ln7LwPgS34gHW6h4R0YxY7WP7Tq+T5rAzsX0mKEFwY9g15RVU
	 T+F4xvMRDe3dZMdiXKldYTSbayR6tLmUawN8CzfMtwQNcvO0iXGAsbyVGjivme8BBl
	 PaMjf8AwYUESGPfMKWiJFnBcsX73HUhO+WwB335Kh3oJJ2OsK8ETFe2ozkGOCx16dv
	 9a523Lm5OGZO02h0pRZaZ/kuu+2XEm2FLZcM5C8vSc9fgeOXy7Fb1Mv75JwK76znZQ
	 ZFpEye9NZRQag==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 19 Nov 2024 15:53:25 +0300 (MSK)
From: George Stark <gnstark@salutedevices.com>
To: <ukleinek@kernel.org>, <neil.armstrong@linaro.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <linux-pwm@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>, George Stark <gnstark@salutedevices.com>
Subject: [PATCH v3 0/4] pwm: meson: Support constant and polarity bits
Date: Tue, 19 Nov 2024 15:53:14 +0300
Message-ID: <20241119125318.3492261-1-gnstark@salutedevices.com>
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
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189267 [Nov 19 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/11/19 09:12:00
X-KSMG-LinksScanning: Clean, bases: 2024/11/19 09:12:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/19 08:41:00 #26886618
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

Changes in v3:
  pwm: meson: Simplify get_state() callback
    - drop local variable channel
  pwm: meson: Support constant and polarity bits
    - drop meson_pwm_assign_bit() and implement bit assignment in-place
  link to v2: [2]

[1] https://lore.kernel.org/linux-arm-kernel/20241007193203.1753326-4-gnstark@salutedevices.com/T/
[2] https://lore.kernel.org/linux-arm-kernel/l5xvdndysdvtil472it6ylthcfam5jp7lh3son45mezq7dh2yk@3yj557k2o5k5/T/

George Stark (4):
  pwm: meson: Simplify get_state() callback
  pwm: meson: Support constant and polarity bits
  pwm: meson: Use separate device id data for axg and g12
  pwm: meson: Enable constant and polarity features for g12, axg, s4

 drivers/pwm/pwm-meson.c | 105 ++++++++++++++++++++++++++++++++++------
 1 file changed, 91 insertions(+), 14 deletions(-)

--
2.25.1


