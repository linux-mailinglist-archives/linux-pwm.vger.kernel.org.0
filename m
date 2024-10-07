Return-Path: <linux-pwm+bounces-3518-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EBD993783
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Oct 2024 21:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569161F24A6C
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Oct 2024 19:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642E91DE3D1;
	Mon,  7 Oct 2024 19:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="NVFTG0m9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3881DE2D4;
	Mon,  7 Oct 2024 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728329867; cv=none; b=QE0D2PMUs25SM+kYQATl3Vui5urChI68o/wwxjRPFJYaOpcvTxnq+mw8Ip6bY2O63SvpbNwESR/2MjpuGsSUb5y6H0vEXi0zrpngsbdwZDog8SkdF34Gn/+XzGK/2JpQ76oAby6fE/emKMeky2wpjpnBHsarJPbvWGFAgF364PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728329867; c=relaxed/simple;
	bh=kHsBNLoYlJPJt2nU3a6Sy6UGrnQko1NVbxWaEggv5J0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HFYR1LVyFpCeG1sWuKS+V0IVqvFLmwY7N4omUzVooFrBolnzYx6Wc9o4NExcCh24j9W3B1LYpjRZdIsDLwqyta2TNK7o1MU6t2qUn/pwJqM2d0QnSU22HkBviG/zP5ZhNHxaGNDWo0BoRgN9JHe2laaKAZqcc/niPMjFP0FjHHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=NVFTG0m9; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 387B1100008;
	Mon,  7 Oct 2024 22:32:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 387B1100008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1728329531;
	bh=auwqfHEF7ME53k772fd+EeQA9nJK3Tgrnfl5jkgQXW0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=NVFTG0m9hBCOZnwq8gKbYdo1TmDaRc2Ili1m4JOv54oqKfpKsmSP+BtgmuN3SddSQ
	 GSfbbcAj2EAiJx/9UYfY5YMc7a/lwJJqjDEfkXblhzyQshQXxBqdUL8GBHswPzsFlz
	 siSqY7Q060gxXQzFbdPWoNtnYLsXw7ZhUqT87lKtQirSp6xF7G/HiKLJw6U3NVI7En
	 so6cypLtcb3irbJfzb75a6DCN2QVCAau1u+gtTXMFU33vkP53EisecAh7f927gQCF3
	 ri9U7DqT+xHxvTLyDCbT6NP2deyuwI5RHs18/CScD4WssBZ5aN0Wt6zM8jxtCO8IHw
	 Edt//fXB8DcDQ==
Received: from smtp.sberdevices.ru (unknown [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon,  7 Oct 2024 22:32:11 +0300 (MSK)
From: George Stark <gnstark@salutedevices.com>
To: <u.kleine-koenig@pengutronix.de>, <neil.armstrong@linaro.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <linux-pwm@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>, George Stark <gnstark@salutedevices.com>
Subject: [PATCH 0/3] pwm: meson: Support constant and polarity bits
Date: Mon, 7 Oct 2024 22:32:00 +0300
Message-ID: <20241007193203.1753326-1-gnstark@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 188277 [Oct 07 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/07 17:50:00 #26714324
X-KSMG-AntiVirus-Status: Clean, skipped

This patch series add suppot for amlogic's newer PWM IPs hardware features:
constant and polarity bits.

Using polarity bit for inverting output signal allows to identify inversion
in .get_state() callback which can only rely on data read from registers.

Using constant bit allows to have steady output level when duty sycle is zero or
equal to period. Without this bit there will always be single-clock spikes on output.

Those bits are supported in axg, g12 and newer SoC familes like s4, a1 etc.
Tested on g12, a1.

George Stark (3):
  pwm: meson: Support constant and polarity bits
  pwm: meson: Use separate chip data struct for g12a-ee-pwm
  pwm: meson: Enable constant and polarity features for g12, axg, s4

 drivers/pwm/pwm-meson.c | 94 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 87 insertions(+), 7 deletions(-)

--
2.25.1


