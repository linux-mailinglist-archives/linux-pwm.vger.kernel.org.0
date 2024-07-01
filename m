Return-Path: <linux-pwm+bounces-2641-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA11A91E01C
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jul 2024 15:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14BE61C225BC
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jul 2024 13:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785DA15ADB5;
	Mon,  1 Jul 2024 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="UY1il4SO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F19154BE7;
	Mon,  1 Jul 2024 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838894; cv=none; b=oqzw2nSiKjDUpZv5wAkSedCvMov+sbd8sU9vuH1ZJ9NDiA16JGGQoslBI+ZUM29H/PwfP9rR+R+XmS1H2lZJF3Cf+caiDdSXZH1BJ27CWZZhtKON6xJc56V7vR09z6mnRTi34HW+RurFDj3AIiUiO/vXIkW6+BuoUsZqWZzrKos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838894; c=relaxed/simple;
	bh=2dwIRvYJsgZnBw5Li/TobLh4i//fTecCDkTu18lUU0Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dMt7aXkMa3wAP82p/Fxh1mhdWgdMd0C+3raNa+3O27z65GiDJnuDSMbz4D8uXKXKJjj8wMH9DRIeVHWd5vuQS9dHTD7x2BRwIV624VD9tsM62h3g1JQX8AKDsLxMAstHhojmVk5bsmnLRgspKhZR65vAzNRoC73gcGPL6oAr+m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=UY1il4SO; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id AEBD2100020;
	Mon,  1 Jul 2024 16:01:22 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru AEBD2100020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1719838882;
	bh=u8k3tcTnpuTH/PJpX5qayEs3QW/i3kdJlSiuUB2g0ww=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=UY1il4SOWjSidlDgmgTqG0dbU9WJLinsFAMfLf7lwuXSto4H/3192vEfBpz/7p5lL
	 nYon/u79o0J5f7/Wsuo8T22tiJrDrCii9GDO8S8t3xxF6GjpQWSwsQByktRSiLAbQR
	 IdEpNdPOs5SaPka3G5FTBuDgUq46UK03B87kbFwwWuvwlHjbaz8l2fpVX1whRBi00J
	 +kbGOo8LRTE6KnHimZCvvz575pUhcVd9swPF6CAdJwkBmMipG++oCvv0xrnr2f+7BO
	 vBpFNt5kFPjq2gnffhNqwmqwPfR5W3K8Na+UtYBkDIvKCoRQVqiGOZNcgxFSI3XvaB
	 NORGDfdXRA8hw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon,  1 Jul 2024 16:01:22 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jul 2024 16:01:22 +0300
From: George Stark <gnstark@salutedevices.com>
To: <ukleinek@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
	<jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
	<hkallweit1@gmail.com>
CC: <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>, George Stark
	<gnstark@salutedevices.com>
Subject: [PATCH 0/2] add support for meson a1 PWM in dts and bindings
Date: Mon, 1 Jul 2024 16:01:11 +0300
Message-ID: <20240701130113.433169-1-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186241 [Jul 01 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 21 0.3.21 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/01 11:44:00 #25786379
X-KSMG-AntiVirus-Status: Clean, skipped

Add support for meson a1 PWM in dts and bindings. Due to pwm driver code is fully
the same for a1 and s4 then a1 compatible defined with s4 as fallback.

George Stark (2):
  dt-bindings: pwm: amlogic: Add new bindings for meson A1 pwm
  arm64: dts: meson: a1: add definitions for meson pwm

 .../devicetree/bindings/pwm/pwm-amlogic.yaml  |   2 +
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi     | 215 ++++++++++++++++++
 2 files changed, 217 insertions(+)

--
2.25.1


