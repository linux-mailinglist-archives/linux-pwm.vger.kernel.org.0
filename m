Return-Path: <linux-pwm+bounces-6766-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D38F1AFC6FA
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 11:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D78AA3ACC59
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 09:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F1022541C;
	Tue,  8 Jul 2025 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XIzuAUkN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E2618A6DB;
	Tue,  8 Jul 2025 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751966813; cv=none; b=KvCQmyoXyd6zlUtHOmbnln2aZpaEnLtaVwLWH6CbkPPXBruIKeqBLMe7MjKNEDjid+q+lXTInDJrqiBguJWwhs1Gl1Zs3UwFv/sS8eg76th8Cn8E8uQg16XUKLVEhxoKT8myFF6FhmPLfsR55QdyTnLX8VtbWxwo2HytS5eeUts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751966813; c=relaxed/simple;
	bh=ggWTFNYCxsrqo6DjnnSXX54N8XQSfll0bhNuxOK1H6c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=GBTsUm1QdH06qtNkCXyZf9olpHWcn4oWq1ForhEh0JMXezvTrljiiOrBL94b08zOD2m71agDhfE46rg6Jmsru4FTclr65JZa12VcvOmqdQlj2KbebGJQlpuoxEVtsQR5GFyoMwp6jX8TinNU1AQkV8TyIt2EklUVFOoxG7XvpZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XIzuAUkN; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3F2B043B12;
	Tue,  8 Jul 2025 09:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751966808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k8lgCeFVnrvw9eF9vngfEFxVvemv2ICKjq/oNqffKn4=;
	b=XIzuAUkNmaxbSXgfaM0gguyLFDnzCB776GRY6bYLaWaP4aKnsC0duQvMoMQfH8VLl85BVz
	bjJH04FdbOj9cRkcHVZVM7WIC0sK0vSa+bepz+3eYF6NRsGHH9yMTaFm4NC3c96e6OP8Ct
	YPEGIa3+UkTDLpyHIesgZ5gnYF54DrqR895Bp8+QZ9Pusp+nOWFaRZTYOIjT9aeaUEF0fH
	dvUtBirHVusHi4RYlDQgYyWpH8NZEJWc/u0FwuZj9eW3xFT5K9dP2ZI8Fbty+yTG3qo8gY
	exY/KyEHgw7wR1kt4OBVrjwiBGu/gH5f4wobqLjfDpSb4bUN+CcZ1SAZx/Bjtg==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 11:26:47 +0200
Message-Id: <DB6KEG68GC91.VC8LHYCZCLT7@bootlin.com>
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Michael Walle"
 <mwalle@kernel.org>, "Mark Brown" <broonie@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <andriy.shevchenko@intel.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v10 10/11] input: misc: Add support for MAX7360 rotary
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250530-mdb-max7360-support-v10-0-ce3b9e60a588@bootlin.com>
 <20250530-mdb-max7360-support-v10-10-ce3b9e60a588@bootlin.com>
 <rfxdncj7o6ow53jthveea6byresoz3vwts3h4cqjezn3egrny3@sd63xrnhwm6s>
In-Reply-To: <rfxdncj7o6ow53jthveea6byresoz3vwts3h4cqjezn3egrny3@sd63xrnhwm6s>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkfevhffvuffofhgjsehtqhertdertdejnecuhfhrohhmpedfofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugdfuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepfeetvdfggeetheejjedtfefghfetvedvtddvjeelgefhfeeugfeltdetuddvteeknecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddvpdhrtghpthhtohepughmihhtrhihrdhtohhrohhkhhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrg
 hdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghmvghlrdgsohhuhhgrrhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Wed Jul 2, 2025 at 11:05 PM CEST, Dmitry Torokhov wrote:
> Hi Mathieu,
>
> On Fri, May 30, 2025 at 12:00:18PM +0200, Mathieu Dubois-Briand wrote:
>> +
>> +static void max7360_rotaty_report_event(struct max7360_rotary *max7360_=
rotary, int steps)
>
> s/rotaty/rotary
>
>> +	if (max7360_rotary->relative_axis) {
>> +		input_report_rel(max7360_rotary->input, max7360_rotary->axis, steps);
>> +	} else {
>> +		int pos =3D max7360_rotary->pos;
>> +		int maxval =3D max7360_rotary->steps;
>> +
>> +		/*
>> +		 * Add steps to the position.
>> +		 * Make sure added steps are always in ]-maxval; maxval[
>> +		 * interval, so (pos + maxval) is always >=3D 0.
>> +		 * Then set back pos to the [0; maxval[ interval.
>> +		 */
>> +		pos +=3D steps % maxval;
>> +		if (max7360_rotary->rollover)
>> +			pos =3D (pos + maxval) % maxval;
>> +		else
>> +			pos =3D clamp(pos, 0, maxval);
>
> Should it be clamp(pos, 0, maxval - 1) by chance?
>

Comparing with the behaviour of rotary_encoder.c, yes, maxval should
probably be excluded.

Good catch, thanks!

> Otherwise:
>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Thanks.

Thanks for the review!

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


