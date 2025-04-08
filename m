Return-Path: <linux-pwm+bounces-5374-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A629A7F719
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 09:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC1F1891342
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 07:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485A925F996;
	Tue,  8 Apr 2025 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M3xXo6sy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A41219A9D;
	Tue,  8 Apr 2025 07:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744098885; cv=none; b=gSUXpc3No8D/Zza+rjK/YGd/1MZ3cJST0HChU4+doz2LduGE3zwoCMzk9TiAvENvdUb/TAyXww+/9uIHVFdm0lptvb6dXat6xGDG4cZH3ly0POxP+dmOGUHVMpmnn237yXtihXRC26DGvIiwSxriTILxp1hwlh6lFFbJqRSIejU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744098885; c=relaxed/simple;
	bh=xxetUDTZlqHK0fEp7Vi6b/HN4t5K5gsdbrTM3CzIMZc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=SK5WXiWCB2eXWz0RHnBZx4fZ0ALxka3zv0uGiTMgbMXSYn/Tvo3ZNETcxYDsJXEy3oCHhEZDRX/yGFrXsW7T+Wp+nLzox157aNxnlVRczNGNdObpoHxIjJ+vOvBIWVVszZy8+3HLwW6Yedz4hKsV4JwfdU1/mrDf+A//pLQ12N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M3xXo6sy; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A30B420483;
	Tue,  8 Apr 2025 07:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744098875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JKsaa5Qw6MpBCcMH9HOs47mW1tDXG/PfpB5X4FVgPbw=;
	b=M3xXo6sykhWw+N7TXiXB1g6Hcor8ZMEk7uaESpU493qpZPI9Eg9SHzDy7EE0z5uGqY3/qW
	CZy+juqPIIl8RcI/C9xJClXuX3lz1HMgbJXpN1fIDd2ISJdc77ek3rhHgSdZVBIpQoTXM8
	lFFC5t8zBs1piZNyDhqwaOK/xI3zsJULaVlSKpcWEM/+4QQmbiPdN4EYFC1VE1etA2bLW7
	TDp2fFPL1rmSR3gtwP54pbspGaoacRHRKje1HZtlAOxKXv+OGZrzUUrRcjXeuyLEvKxvjO
	forGNMl3mo/lNByht2d9qsT+7aULp2h+/a7lEyZ2SFGunVTen1DALXBUmgWNyA==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Apr 2025 09:54:27 +0200
Message-Id: <D913G6I023M1.NLMLJDZ1PYSA@bootlin.com>
To: "Inochi Amaoto" <inochiama@gmail.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Jingbao Qiu" <qiujingbao.dlmu@gmail.com>
Cc: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <unicorn_wang@outlook.com>, <dlan@gentoo.org>, <linux-pwm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/2] pwm: sophgo: add pwm support for Sophgo CV1800
 SoC
From: "Thomas Bonnefille" <thomas.bonnefille@bootlin.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20240501083242.773305-1-qiujingbao.dlmu@gmail.com>
 <20240501083242.773305-3-qiujingbao.dlmu@gmail.com>
 <k6jbdbhkgwthxwutty6l4q75wds2nilb3chrv7n4ccycnzllw4@yubxfh5ciahr>
 <D8Z4GLQZGKKS.37TDZ7QBN4V4N@bootlin.com>
 <j74t2zqvoslo5fgmea4kp434tafgchkncytofj65zbbt7ivcqy@auboc3pkdiz3>
In-Reply-To: <j74t2zqvoslo5fgmea4kp434tafgchkncytofj65zbbt7ivcqy@auboc3pkdiz3>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddvheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvfevuffhofhfjgesthhqredtredtjeenucfhrhhomhepfdfvhhhomhgrshcuuehonhhnvghfihhllhgvfdcuoehthhhomhgrshdrsghonhhnvghfihhllhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeetuedvlefhtedujeevtdffgeevjeetuedvudehtefhgfeuteefhefguddtfedtteenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehthhhomhgrshdrsghonhhnvghfihhllhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehinhhotghhihgrmhgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhklhgvihhnvghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehqihhujhhinhhgsggrohdrughlmhhusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrg
 hdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuhhnihgtohhrnhgpfigrnhhgsehouhhtlhhoohhkrdgtohhmpdhrtghpthhtohepughlrghnsehgvghnthhoohdrohhrgh
X-GND-Sasl: thomas.bonnefille@bootlin.com

On Mon Apr 7, 2025 at 9:21 AM CEST, Inochi Amaoto wrote:
> On Sun, Apr 06, 2025 at 02:16:41AM +0200, Thomas Bonnefille wrote:
>> Hello,
>>=20
>> On Sat Jun 1, 2024 at 1:53 PM CEST, Uwe Kleine-K=C3=B6nig wrote:
>> > On Wed, May 01, 2024 at 04:32:42PM +0800, Jingbao Qiu wrote:
>> >> [...]
>> >> +	if ((state & BIT(pwm->hwpwm)) && enable)
>> >> +		regmap_update_bits(priv->map, PWM_CV1800_OE,
>> >> +				   PWM_CV1800_OE_MASK(pwm->hwpwm),
>> >> +				   PWM_CV1800_REG_ENABLE(pwm->hwpwm));
>> >
>> > This looks strange. If BIT(hwpwm) is already set, set it again?!
>> > Also if you used the caching implemented in regmap, you don't need to
>> > make this conditional.
>> >
>>=20
>> I was testing the series and noticed indeed an issue in this driver at
>> those lines. If PWM_CV1800_OE isn't set by something else than the
>> kernel it will never be set and so, there will never be a PWM outputted.
>>=20
>> Using :
>>     if (!(state & BIT(pwm->hwpwm)) && enable)
>> Solved the issue but as Uwe said you can probably rely on regmap caching
>> to avoid this condition.
>>=20
>> >
>> > ...
>> >=20
>>=20
>> Do you plan on sending a new iteration some day ? I may have some time
>> to continue the upstreaming process if you need to.
>>=20
>> Thank you for this series !
>> Thomas
>
> I suggest checking existing spi-sg2044-nor driver, which may reduce your
> work for upstreaming.
>
> Regards,
> Inochi

Hello Inochi,

Thank you very much, however even after reading it I can't see the link
between the SPI NOR controller driver of the SG2044 and the PWM driver
for the CV18XX series ?

Regards,
Thomas

