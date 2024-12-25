Return-Path: <linux-pwm+bounces-4516-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CD59FC4DD
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Dec 2024 11:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B850E16310D
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Dec 2024 10:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD9218E028;
	Wed, 25 Dec 2024 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="hqs9GlJo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C322167DB7;
	Wed, 25 Dec 2024 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735124225; cv=none; b=A1iF3piWwnzanIuP8q6AqDuhtpy6WkYC2m5yvYYf7d1WifUy3l57ys8322YQKT/Xd+mbd5OwFjIVDmiqwShiVibReST9ZVqQURcLkhmJBcKX8nASJT91SGnAQDYFURzBUcgm/IEdKT5uXzPp+1kiEmLM6SvJjjL8F78N0SY2p0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735124225; c=relaxed/simple;
	bh=S3RTLQZzhyEkwkaDgHibDflGZbEHGX+hjbFKOD/RULY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R6YvFiyNu/6Ebg7MOSogfXBC5ADu7rEbOrWCXTzGWBaMeY8ajZwvU0A1v5lZrEWjeQk5ZjjMtZmQzd+T9DuTSKJjG+sLcH3gzJMEwLI/mP9y0/JtBtq0aA24cr1lg1QQjwvTml/KIdX2wCYHntqM/mFqi8F7FT5fjICk2CPg+i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=hqs9GlJo; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id EC96E120029;
	Wed, 25 Dec 2024 13:56:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru EC96E120029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1735124211;
	bh=aW6usGsOL7OyXjgNlUS/zBBhFNHbOhEYlvaEKoGU80c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=hqs9GlJo+qr77qbsabqXfzrRFlmeRg4ei9Y8pQHWTvGE+Vj14PS9PhPB4Ijx/Cf9g
	 2dC7QP66eyU9561UsIUmSGutVVWOsAx20Rygvt5eEcQ70I7a6RS9J324xdoD8Bfag3
	 KdyopbU7F38MkpWMYK64jRQ7dr4QmoYJ66ZVzQoVfY9HLRS7g2NkgBaTO+1opx2eBp
	 LIWYdg10XQ4Yv3kLmst2/3FUA1/0oToYryM1JFWTHzpzHBZqjo6krHT4iw9rmsuVh3
	 wIDZkffQKmA1IZmIAueGexg3LZ/MgogjUXHnNxgB871GMjK/CbHvLamTWknHub04r4
	 Mb0LnDAUQNgzA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 25 Dec 2024 13:56:51 +0300 (MSK)
From: George Stark <gnstark@salutedevices.com>
To: <ukleinek@kernel.org>, <neil.armstrong@linaro.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <linux-pwm@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>, George Stark <gnstark@salutedevices.com>
Subject: [PATCH 0/2] pwm: meson: fixes
Date: Wed, 25 Dec 2024 13:56:37 +0300
Message-ID: <20241225105639.1787237-1-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 190053 [Dec 25 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 49 0.3.49 28b3b64a43732373258a371bd1554adb2caa23cb, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;git.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/12/25 08:56:00
X-KSMG-LinksScanning: Clean, bases: 2024/12/25 09:00:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/12/25 07:56:00 #26914998
X-KSMG-AntiVirus-Status: Clean, skipped

The 1st patch from the series is only intended to drop several unneeded code lines
along with outdated comment. It's too simple to be sent alone.

The 2nd patch adjusts pwm frequency calculation. The patch depends on
not-yet-accepted series:
https://lore.kernel.org/linux-arm-kernel/20241119125318.3492261-1-gnstark@salutedevices.com/T/

Below I researched several cases this patch will affect.
One of the most frequent use of meson pwm in mainline dts files are:
1) wifi clock source and 2) cpu power regulation.

1) wifi clock source with period 32768Hz and 50% dutycycle is configured in DTS like this:
    pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
Here is the calculated and measured frequency output with and without the patch on
several boads/SoCs, where
${CLK_RATE} - pwm clock source
${COUNT_REG} - meson pwm regster with hi and lo values (e.g. PWMEF_PWM_E reg)

*** khadas vim1 ***
${CLK_RATE} -> 166666667
w/o the patch:
${COUNT_REG} -> 0x09EF09EF
oscilloscope measure: 32.7564Khz
calculated period: ${CLK_RATE} / (${COUNT_REG}.lo + ${COUNT_REG}.hi + 2) = 32756.8134827 Hz
with the patch:
${COUNT_REG} -> 0x09EE09EE
oscilloscope measure: 32.7693Khz
calculated period: ${CLK_RATE} / (${COUNT_REG}.lo + ${COUNT_REG}.hi + 2) = 32769.694652 Hz

*** khadas vim3 ***
${CLK_RATE} -> 666666656
w/o patch:
${COUNT_REG} -> 0x27BC27BD
oscilloscope measure: 32.7652Khz
calculated period: ${CLK_RATE} / (${COUNT_REG}.lo + ${COUNT_REG}.hi + 2) = 32764.8624367 Hz
with the patch:
${COUNT_REG} -> 0x27BB27BC
oscilloscope measure: 32.7684Khz
calculated period: ${CLK_RATE} / (${COUNT_REG}.lo + ${COUNT_REG}.hi + 2) = 32768.083362 Hz

*** meson a1 board ***
${CLK_RATE} -> 64000000
w/o patch:
${COUNT_REG} -> 0x03D003D1
calculated period: ${CLK_RATE} / (${COUNT_REG}.lo + ${COUNT_REG}.hi + 2) = 32736.57289 Hz
with the patch:
${COUNT_REG} -> 0x03CF03D0
calculated period: ${CLK_RATE} / (${COUNT_REG}.lo + ${COUNT_REG}.hi + 2) = 32770.0972862 Hz

2) pwm power regulator. Power is regulated changing duty value with the constant period
*** meson a1 board ***
required: period 1500ns (667kHz), duty 70% for 0.8V
${CLK_RATE} -> 307200000
with the patch:
${COUNT_REG} -> 0x01410089
calculated period: ${CLK_RATE} / (${COUNT_REG}.lo + ${COUNT_REG}.hi + 2) = 667826.086957 Hz
calculated duty: (${COUNT_REG}.hi + 1) / (${COUNT_REG}.hi + ${COUNT_REG}.lo + 2) = 0.7
oscilloscope measure: 667.8Khz, 1498ns/1049ns, duty 70%
w/o the patch:
${COUNT_REG} -> 0x0142008A
calculated duty: (${COUNT_REG}.hi + 1) / (${COUNT_REG}.hi + ${COUNT_REG}.lo + 2) = 0.69
oscilloscope measure: 664.9Khz, 1504ns/1051ns, duty 69%

*******************
**** ATTENTION ****
*******************
There's a potential problem related to meson_pwm_get_state's change.
When pwm-regulator is initialized before the kernel is loaded and incomplete
voltage-table is used (meson a1 board vendor kernel)

voltage table fragment from kernel dts:
  compatible = "pwm-regulator";
  voltage-table =
  ...
  <800000 70>,
  <790000 73>,
  <780000 76>,
  ...

pwm regulator is initialized in bootloader bl2/bl3.x
${CLK_RATE} -> 24000000
${COUNT_REG} -> 0x00190009
oscilloscope measure: 666.67Khz, 1500ns/1083ns, duty 72%

pwm_get_state w/o the patch returns:
pwm period: (${COUNT_REG}.hi + ${COUNT_REG}.lo) / ${CLK_RATE} = 1416 ns
pwm duty: ${COUNT_REG}.hi / ${CLK_RATE} = 1041 ns
duty: 1041 / 1416 = 73%
Value 73% is found in the voltage table and everything is ok

pwm_get_state with the patch returns:
pwm period: (${COUNT_REG}.hi + ${COUNT_REG}.lo + 2) / ${CLK_RATE} = 1500 ns
pwm duty: (${COUNT_REG}.hi + 1) / ${CLK_RATE} = 1083 ns
duty: 1083 / 1500 = 72%

72% is not found in the voltage table.
In that case pwm-regulator driver on its own sets the minimum voltage from the table.
If this is the cpu power regulator then cpu may hang due to voltage is lowered
w/o prior proper frequency lowering. In that situation voltage-table should be
adjusted to have intermediate values.

Just before sending the letter I've found the only mainline board that may be
broken by this patch:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
I can patch meson-s4-s805x2-aq222.dts' voltage table or propose patch to pwm-regulator
to change the way pwm-regulator deals with out-of-table pwm values.

George Stark (2):
  pwm: meson: Simplify meson_pwm_cnt_to_ns()
  pwm: meson: Fix computing counter register

 drivers/pwm/pwm-meson.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

--
2.25.1


