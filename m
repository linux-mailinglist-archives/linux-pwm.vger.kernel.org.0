Return-Path: <linux-pwm+bounces-5797-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD34AA6BB7
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 09:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B69E97B31F0
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 07:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352B126773A;
	Fri,  2 May 2025 07:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eDAtgNpI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F9A267709;
	Fri,  2 May 2025 07:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746171358; cv=none; b=hijseKgxOGdORREbnk2uayYS5EUPS5DSPBjIDvWF783oN/41dOGSKhzoYPNXu73sfAzww9v5lxy4fpJNIFl5nh/gTA6zyjvhXFEP93rBdgEafLJ0DHeQMyq4A5jqIDL4xxpcoWOHVTDZJbfCl0Gjnqr9NuUBOo5Or8cRbc+zdHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746171358; c=relaxed/simple;
	bh=7SzGhijHGcDpGmbMY9GoSxFvyrhaiVItUu3izTL/Iug=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=KbJtZmrtLVNFefkMfncKn0fYz+u+i0OKmO2HACkX6EiIaPr5rEZm+4wHztjdDmsqMhHewg+6hdHA0FRtnCrCE6NF5gBqiDCl6aNPcKNv8PIbav//SzCfnr1rDYRmPXX8dKHgnRL1LpxmLIjc4f5G5iJhCqCVqrYpKGSbCwRl8iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eDAtgNpI; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2388F43B5D;
	Fri,  2 May 2025 07:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746171347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I4hyhLmJzZSjiqbJhNLTC62EEcInqQ9hw2AM6wZ9RsY=;
	b=eDAtgNpIbZc1oGoe5ruFOwTuzyuOJ3rMW2HDFZZ9NamH3mE1O57Pj+P9KtDrqR+Qc0ODt6
	zIEPfQHj/adwzIZCX2FmMDjGa9sP2FyVCy0k7+mR82xvmG5VGQ4bMnzVMXkFpP+o5A18do
	B/V5Hsm4OJbmY1/kTUBD7OPbSyAXpDosleES+/SHBACV0BEbKRmMjrauev4k6kaCMNjYig
	XGcVcJ6HXPvJGuDCdGht6DESTYZW8cpnEJ/iy1h1/qOy05r/VD5GpLEAdxx2nD3rOdUwQd
	CFz+LVObL7KYrEQXBqzpee9FwGQknpK8dgIbh1MThr0oPB8OpcKjBu3ondA4iQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 May 2025 09:35:45 +0200
Message-Id: <D9LI2Y0J2KZY.15PIU2T55GIH0@bootlin.com>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Kamel Bouhara"
 <kamel.bouhara@bootlin.com>, "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Michael Walle" <mwalle@kernel.org>, "Mark Brown"
 <broonie@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <andriy.shevchenko@intel.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Lee Jones" <lee@kernel.org>
Subject: Re: [PATCH v7 02/11] mfd: Add max7360 support
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
 <20250428-mdb-max7360-support-v7-2-4e0608d0a7ff@bootlin.com>
 <20250501125943.GN1567507@google.com>
In-Reply-To: <20250501125943.GN1567507@google.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedukeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvefhvffuofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeftedvgfegteehjeejtdefgffhteevvddtvdejleeghfefuefgledtteduvdetkeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepk
 hhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghmvghlrdgsohhuhhgrrhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplhdprhgtphhtthhopegumhhithhrhidrthhorhhokhhhohhvsehgmhgrihhlrdgtohhm
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Thu May 1, 2025 at 2:59 PM CEST, Lee Jones wrote:
> On Mon, 28 Apr 2025, mathieu.dubois-briand@bootlin.com wrote:
>
>> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
>> +static int max7360_probe(struct i2c_client *client)
>> +{
>> +	struct device *dev =3D &client->dev;
>> +	struct regmap *regmap;
>> +	int ret;
>> +
>> +	regmap =3D devm_regmap_init_i2c(client, &max7360_regmap_config);
>> +	if (IS_ERR(regmap))
>> +		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to initialise regm=
ap\n");
>
> dev_err_ptr_probe()
>

I believe dev_err_ptr_probe() is meant to be used for the opposite case,
where the variable holding the error is an int but the function has to
return a pointer. Here regmap is a pointer but we have to return an int,
so I believe neither dev_err_ptr_probe() or any similar macro can really
help us.

OK for all other points.

Thanks for your review,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


