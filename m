Return-Path: <linux-pwm+bounces-2245-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2B98CFEF6
	for <lists+linux-pwm@lfdr.de>; Mon, 27 May 2024 13:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2629B21821
	for <lists+linux-pwm@lfdr.de>; Mon, 27 May 2024 11:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBD41527BE;
	Mon, 27 May 2024 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Y8SfZw9s"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2552A1527A8;
	Mon, 27 May 2024 11:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716809393; cv=none; b=hT3aKEtLxhPJ+CGgKCa6Hxftqw8xTVbyrnfmnI1ieDSejlDS+76eeJ7JW4OIJSmUITWFMXL3Nz7JHjLnTh+zMvRJUNWRXe9hA1bfwdcSiIsZ6YX0TIgApfIIEBMmOJ3Fx0rc5jMc6Gtk5QaF2xcaiwJkCelA+mFru9jN0gvxyPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716809393; c=relaxed/simple;
	bh=CGndhDS38R/fmtI3ccV+gGKvVLXk98QyQiAhae+fn3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HUhu3Ovkbw8hkeZBCK+nlfqcoL0pdQ3t/KUauevHOIC+j8bfcJH5ufyaCZByC5MMfpwLh7FmdfX1oUAXgeDcPiNV6aiIjCrXEz2D1ffmqbvCCUTqDyhIelo+IOdiOn3m356ZSd0BWbtQmSSoKfAuj7hlWuGX2UPi+n1ry1ti45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Y8SfZw9s; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1716809381; x=1717414181; i=wahrenst@gmx.net;
	bh=p87Q8UkjB3GPaIDrH5V9qD5k2oMnw1gD5uOpf40Na5g=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Y8SfZw9sR0gSOt1BeI6ejt8RIVJNmSXOngNRkz7Gf9hSJDZeFlLgzdzFGLL0c1sv
	 wG0GFv1MlUKbkwVUdTI4wOv1tubultHmpDK3ai3dBuUyGhJ8fkd+CqqNDQZFlQIut
	 nx41UbbcuMBRozDikHWrZ/uFPKiZqgmtz5pfJ0H/qwNjuPcGyfQT+UokMECG1mktO
	 mxGUH1DKLuHjx2+FLc0E2B8g0C+FVUlz9QdW7We9SWl013yNlHXMoqASRtkYELZqf
	 s9z+pdf3libRkADINV0iFlUW3t/np+pQdiatUscwryj+FEKMR16PBfEbq5mAdx2pf
	 z86MuLsgFMlkR5WXUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWih0-1s0Sk82qRk-00X6bO; Mon, 27
 May 2024 13:29:40 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: andy.shevchenko@gmail.com,
	Philip Howard <phil@gadgetoid.com>,
	Sean Young <sean@mess.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V5 0/2] pwm: Add GPIO PWM driver
Date: Mon, 27 May 2024 13:28:55 +0200
Message-Id: <20240527112857.90554-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D81H1mK1sfWf5rt6dOOcbqK6ZiuKGXEz5C0O2GAfdFADnY27NZe
 WkyCQP3J7aGqZhITBAqlgi1t1UQROET8w7K7Rlb2XdBCV+h/6njKao9JJuIb0F1Dzeibbrv
 FGECLcSZ8SbULGctm4WPn/VXEi8+VXTxsrA1iJ8WeAqCOXgejfwfqINXRZKLDWLFF3HBVxU
 GNieQnhe3RTyIQhBz16ZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vGHAvInGaPM=;Rx0zDoyG5JH2uEPVx8ormyYSTNA
 zuRMBKn7Qx/MhZN/9jitQiMYUktc17h6BGx5Ph8AjeTzFwmZMfSmn7Uz30izEDXTwSD4/YJLU
 xpia5nN/XgSoTkwgPyJl9C6nZBRJV7iARVznhDCIP+0mUbko9Fcwg3I0IaNs+QCFVnb9d1IYo
 JBP79pdY275UQbk8QPWQ+Q4y6yo1dNG6wHWAV0WpvehtZwiOVhDOzXyHcQL+b6shzM9VxhH4I
 11H4aajF2iHohrEbqEN53u6DhlOyK9VCEcpMWMBxeP6T5Zoi72vbnGS80kgLNxQ4jF+clS5DF
 vl6Ov576wEy8F7mxEvlMOxT95igqUF9DmHkH4/ZckXYkTDBU/qF54pqXbjbMAhz7DHmDuKi7b
 pCrqGLbbCJJ+cin2WXQbJrBW2Us8166ejfvvWCdi7CN3GwwcV1sgqeu2TPN/Ur9YKSBmBenbF
 mstPqJechtqjQSEt2KEY5nLOmEeXCFQFD5p2LDLv8h5LjHMdyrjdLhh5triKjUpaBczkIUHvb
 085Qtot+U3wP4GHwZNoUdLkxS00PuxDbPzedoYXBJacklBlCFrOAswwJItpjbiL75AfQaAuhR
 EslC2U1FPIem7g1jc4mSouZdka7of7znN0dDr8mJk2Ug9yAQyvYyZt8Pll6B/7L//U3HTP3OL
 JtEG/fJd0DU4F9TJRsPi3a/gVfUwM8TnNDoGFj8+SaoiU1etiyapMmQi/sxoB+cjD7N46Gmlh
 RX0WxrmqZgAavK5Ntbn825wjG3ANPTEf3BgGJAE5rcSJJok528HONjz6QbAbQn0rK2mWxKoSs
 Z4TrEpJntbEi0gse0ZmMA6M+m2s88wTY2KL5nRcYcvBK4=

Add a software PWM which toggles a GPIO from a high-resolution timer.

Recent discussions in the Raspberry Pi community revealt that a lot
of users still use MMIO userspace tools for GPIO access. One argument
for this approach is the lack of a GPIO PWM kernel driver. So this
series tries to fill this gap.

This continues the work of Vincent Whitchurch [1], which is easier
to read and more consequent by rejecting sleeping GPIOs than Nicola's
approach [2].

The latest version has just been boot tested on a Raspberry Pi 3 B+.

Since i'm not sure that i have the time to finish the driver soon, i'm
happy if someone finish this job. From my POV, V5 of this series only
lacks a solution for possible interrupt storm in case the period/duty cycl=
e
is set too short [3].

V5:
 - add Reviewed-by's for dt-binding patch
 - rebase on top of v6.10-rc1
 - print hr resolution at driver probe
 - fix grammar in Kconfig
 - fix return type of pwm_gpio_toggle
 - implement hrtimer resolution rounding as noted by Uwe
 - use firmware node path instead of GPIO numbers as suggested by Andy
 - adjust some header includes and style issues as noted by Andy

V4:
 - address DT bindings comments from Conor Dooley
 - drop unnecessary MODULE_ALIAS() as suggested by Krzysztof Kozlowski
 - add range checks to apply which consider the hrtimer resolution
   (idea comes from Sean Young)
 - mark driver as atomic as suggested by Sean Young

V3:
 - rebase on top of v6.8-pwm-next
 - cherry-pick improvements from Nicola's series
 - try to address Uwe's, Linus' and Andy's comments
 - try to avoid GPIO glitches during probe
 - fix pwm_gpio_remove()
 - some code clean up's and comments

V2:
 - Rename gpio to gpios in binding
 - Calculate next expiry from expected current expiry rather than "now"
 - Only change configuration after current period ends
 - Implement get_state()
 - Add error message for probe failures
 - Stop PWM before unregister

[1] - https://lore.kernel.org/all/20200915135445.al75xmjxudj2rgcp@axis.com=
/T/
[2] - https://lore.kernel.org/all/20201205214353.xapax46tt5snzd2v@einstein=
.dilieto.eu/
[3] - https://lore.kernel.org/linux-pwm/CACRpkdary+kDrTJ=3Du4VbSTv7wXGLQj9=
_fy7mv0w-Zg+eDvGXVQ@mail.gmail.com/T/#m513f255daa9f30c325d11999cacd0864115=
91bf9

Nicola Di Lieto (1):
  dt-bindings: pwm: Add pwm-gpio

Vincent Whitchurch (1):
  pwm: Add GPIO PWM driver

 .../devicetree/bindings/pwm/pwm-gpio.yaml     |  42 +++
 drivers/pwm/Kconfig                           |  11 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-gpio.c                        | 249 ++++++++++++++++++
 4 files changed, 303 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
 create mode 100644 drivers/pwm/pwm-gpio.c

=2D-
2.34.1


