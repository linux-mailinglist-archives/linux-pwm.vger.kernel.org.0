Return-Path: <linux-pwm+bounces-6234-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 569A2ACC19C
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Jun 2025 10:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2453A3FF2
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Jun 2025 08:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE00A280018;
	Tue,  3 Jun 2025 08:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WDZSywUO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745401B0F17;
	Tue,  3 Jun 2025 08:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748937728; cv=none; b=X5F5orVCGPLLnNYwxnWay9cVtF7jUxMmWxsC1656QvZEdhiDgFs+9X0WUoPgAwAEPARmfnRIWEeNwwXurJNEfdMqjmJvTLYC5ACwQzYJXrRknemYgoMhIJrbRvsB4x4FnOjreXeAg7JLZE6h5R/FlLQ/VQjMdLyUELCpNjVcCbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748937728; c=relaxed/simple;
	bh=9kyAbRkks5+ZeEszHWClhbQsDXdyjmyLLfnOBp9lYlo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=Yn+yYnFWdVuv+e4eKGEI6eTGUwNnjKngiNDhGIQjWXDxXzx3Sf11JKeQs+RUC84Vu7KGCEF1OVE6YzrQHpzExvbwIDESzrPQMUJAunDrIRwbQDJdTgvYt6zblrsU3MHCgSZy7Mbm8kywRJdpNtC4/S2TyIODYXx2nl0uREWmunM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WDZSywUO; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 86E2A41B50;
	Tue,  3 Jun 2025 08:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748937718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c7G1lvf/kPOiqMqyPQvfVR/3H4FSASJvUrGFFqPpIpw=;
	b=WDZSywUOCm9s0b7b7shrPqvPi/saxIBy0AB+0oGbYY/0GihVHZ/C7YgvSIQJt3kkYvn2X1
	fJrUwi9wl+yFSnxps8kWvi5L3JDf5HYNuMICVUaIo9zbfbCRBBIfTcd1nwCioq2SAcHDlU
	ehIMlfXWkuygXwEe1tHLfrcJ+V7yz7Ph11ix2zr95pxcxG1pHD17Cs4ytyx75upwCYWcrY
	6rxJAb8WKDlmzFO+effCCopvMD/Ts9B5Ai8tA2a+YmtQPS+uQTFn0udeFNUTCqXhp6xsxV
	BEe4+A3z7TYV9FLu1cMrk9pVUZcwPQk4ASzrZHld2X/VPj5YPkMZy50ZNFDuzQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Jun 2025 10:01:55 +0200
Message-Id: <DACQOEWJPTU2.34E6UEWBOQ2X8@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Mark Brown" <broonie@kernel.org>
Subject: Re: [PATCH v10 05/11] regmap: irq: Add support for chips without
 separate IRQ status
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Michael Walle"
 <mwalle@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <andriy.shevchenko@intel.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250530-mdb-max7360-support-v10-0-ce3b9e60a588@bootlin.com>
 <20250530-mdb-max7360-support-v10-5-ce3b9e60a588@bootlin.com>
 <aDmKcNez0Bj41Tcv@finisterre.sirena.org.uk>
In-Reply-To: <aDmKcNez0Bj41Tcv@finisterre.sirena.org.uk>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdegtddtudculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffhvffuvefofhgjsehtqhertdertdejnecuhfhrohhmpedfofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugdfuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheevtdekffeuleehkedtvdejhfeihfegtdduveeghedvveelgfevteekveelleetnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvuddvrddutdehrdduhedtrddvhedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdduvddruddthedrudehtddrvdehvddphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdefpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkv
 ghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Fri May 30, 2025 at 12:37 PM CEST, Mark Brown wrote:
> On Fri, May 30, 2025 at 12:00:13PM +0200, Mathieu Dubois-Briand wrote:
>> Some GPIO chips allow to rise an IRQ on GPIO level changes but do not
>> provide an IRQ status for each separate line: only the current gpio
>> level can be retrieved.
>>=20
>> Add support for these chips, emulating IRQ status by comparing GPIO
>> levels with the levels during the previous interrupt.
>
> Please do not submit new versions of already applied patches, please
> submit incremental updates to the existing code.  Modifying existing
> commits creates problems for other users building on top of those
> commits so it's best practice to only change pubished git commits if
> absolutely essential.

Sorry, the patch is still present in the series as I only rebased on
6.15, but it is unchanged from the previous series.

So my understanding is I should have rebased on linux-next master branch
instead, right?

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


