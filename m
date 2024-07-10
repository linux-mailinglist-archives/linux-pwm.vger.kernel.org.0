Return-Path: <linux-pwm+bounces-2759-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E8692DCBE
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Jul 2024 01:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD83B282EFE
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jul 2024 23:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0283158DAE;
	Wed, 10 Jul 2024 23:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="RjyXBTc3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F83848E;
	Wed, 10 Jul 2024 23:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720654890; cv=none; b=dg9BpVNEDLSAVLBguRf+vlgIJsL2D7wappIQ+P+WAExL6dzq4xBLTIJ4xsNNgWIXZu3NHTNGIha61vONAUahKZOXS2bsZthHz1kZJV/qMuAC51NPM2YbrXQx9rbzznN/ZPvltgtSIat7egilrA6lrSS8bxjYIAjdJT4GT1ULjYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720654890; c=relaxed/simple;
	bh=fIXUY8ThIqyTyr6FnvZy1kNkyUcKEQDEhikWI2x7ewY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dDgWugaZteZT+ywZhPt27h+BICgLzOgE/H+xs9A1l46R7fQNgRcptb+49MdPwb4DdVg/7NoepYrosc/UxRouRdYHGjT+NbjKGMUZcVZkA+DUaSF3C7Q4m07pklmSrSH71kDTUjAm1ekgaUboTIKXQCLP3VDaob6qA0Ut4TgJ6FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=RjyXBTc3; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 2E3CD120006;
	Thu, 11 Jul 2024 02:41:23 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2E3CD120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1720654883;
	bh=qRhU2crivn/2xTODAHp+2oPbvB1yAPDlRcyKl3MlgSo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=RjyXBTc3Gl147fEQhywvoAtRVsEkNsqXW67MIWT/VVc33gjZphsFQ4nJEBCWN1hmQ
	 AGD3N1+sSZC5HT7kyFMHjlMN/LnLYBDEr1S7XjrVvJ8ucYPkM7k4yu2HylbvepStFw
	 qMM+XyPQm0ANEZGve3Wo4BlMWfdtT38LH9A+dnPhUVZTsy4yBmRmdDvFMRpsGSuhWi
	 dZoNU4eZEI5q4rM4Eq7IP+vEfuJl0W7+7CBw1Ye0yaBAF0JIAV+ef0+yEePmsWoQVv
	 fV/0RGpYbG2EwOUOe514ufqjQD03nUN/oMP61mSpzUgr+C2e9fwr7pT7m0TDy17Y9w
	 lGh3NZzyT8nLA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 11 Jul 2024 02:41:22 +0300 (MSK)
Received: from work.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 11 Jul 2024 02:41:22 +0300
From: George Stark <gnstark@salutedevices.com>
To: <ukleinek@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
	<jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
	<hkallweit1@gmail.com>
CC: <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>, George Stark
	<gnstark@salutedevices.com>
Subject: [PATCH v4 0/3] pwm: meson: add pwm support for A1
Date: Thu, 11 Jul 2024 02:41:13 +0300
Message-ID: <20240710234116.2370655-1-gnstark@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 186446 [Jul 10 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;100.64.160.123:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;lore.kernel.org:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/10 23:02:00
X-KSMG-LinksScanning: Clean, bases: 2024/07/10 23:02:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/10 21:42:00 #25942395
X-KSMG-AntiVirus-Status: Clean, skipped

Add support for Amlogic meson A1 SoC family PWM

Changes in v2:
  add patch with optional power-domains to pwm bindings;
  fix syntax in a1 bindigns patch:
  - use enum over const for amlogic,meson-a1-pwm beacuse adding more devices here
    are expected
  - leave only base compatible amlogic,meson-s4-pwm in check section
  dt_binding_check and dtbs_check run ok now;
  previous version: [1]

Changes in v3:
  squash power-domains patch into main bindigns patch
  add conditional to bindings that power-domains property is required only for a1
  previous version: [2]

Changes in v4:
  split bindings patch into power-domains patch and new compatible patch
  previous version: [3]

[1] https://lore.kernel.org/lkml/20240701130113.433169-3-gnstark@salutedevices.com/T/
[2] https://lore.kernel.org/lkml/20240701172016.523402-1-gnstark@salutedevices.com/T/
[3] https://lore.kernel.org/lkml/20240702123425.584610-1-gnstark@salutedevices.com/T/

George Stark (3):
  dt-bindings: pwm: amlogic: Add optional power-domains
  dt-bindings: pwm: amlogic: Add new bindings for meson A1 PWM
  arm64: dts: meson: a1: add definitions for meson PWM

 .../devicetree/bindings/pwm/pwm-amlogic.yaml  |  17 ++
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi     | 215 ++++++++++++++++++
 2 files changed, 232 insertions(+)

--
2.25.1


