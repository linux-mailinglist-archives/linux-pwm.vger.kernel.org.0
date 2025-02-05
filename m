Return-Path: <linux-pwm+bounces-4777-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B57A28BD2
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 14:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E644B18874B8
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 13:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD84D127E18;
	Wed,  5 Feb 2025 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RBd9J/y6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CCABA2E;
	Wed,  5 Feb 2025 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762663; cv=none; b=K/9tUmlh1d79WI7ojf2g3KrrGKpXABStIacIHe2N6ioBG7LCDUKSghCiv/2I67JofvBQcGcH5A/XFzGrF57qRPkrDHWtcOok8YXZ/ZJBCAP3SJYA5cfGqsOdZs4O7YU7RROgnTzKANNyTnwEmnyQnAvZBNZLJX5NT9Vuq/OZ+us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762663; c=relaxed/simple;
	bh=Cmexci/AisDlPnaigJd6tGfVHKt40CfzuhrsGY0Fo7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PdDCxZ9e6spjl90y1DcNMNPMj1kQTxdTY3cY7VEZeeYqRB9x2IyA+ysJRdCKcqLDG9XuDTgCZlBwmP4UeAG58vqP4Eg7bbtdIl1oemUf2n+IQMypvKCqxSZTm6dZYQF6fJbcKz+rZXyTrGJWdgmZo61P4aU8Qoko5Pjukho6kfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RBd9J/y6; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6FAEF4428E;
	Wed,  5 Feb 2025 13:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738762658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IAXIH0iwrP+W6cuqbsxVj379S6tYyAYuc6oOo58QvLE=;
	b=RBd9J/y6TYd3m0JuSUKIIIF0LKkQRfoW8vuf6VVxLxQMd17YU7y0EGnSN5HFWGVHRcDCBR
	6ae1KVpJ4+X96P6EntT44pRvK7RALE35ILjzeXCrwTyHgpLbr609Ph8mqQFqNLX0ITSdJr
	kM+Zt8RGDMzp7R2/Ii6tkTr2GMbtzo7kRcGNkJFbyOR5ihRi6nz+/HY7R3p7gxSRGqITV2
	Qh2QTpaY2k56WGN2QEckssUrb4TUeJoy+inR8Zqx+Wc00w0tFkLO8qRjZNrx4AUztA4VgT
	WjPfEDUIBXjLQCTY4Lx1eHCY7lm1YgITRJfc8OuXpAZvY0mML4WkqgJu5p93dg==
Date: Wed, 5 Feb 2025 14:37:37 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 2/2] pwm: Add support for pwm nexus dt bindings
Message-ID: <20250205143737.1315baba@bootlin.com>
In-Reply-To: <ejdh76c4r44gxsdi7gwed65ste3wuunki2jgavc3wsfri5yaex@jccsywdfadgp>
References: <20250205095547.536083-1-herve.codina@bootlin.com>
	<20250205095547.536083-3-herve.codina@bootlin.com>
	<ejdh76c4r44gxsdi7gwed65ste3wuunki2jgavc3wsfri5yaex@jccsywdfadgp>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeehlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthekredtredtjeenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeviefffeegiedtleelieeghfejleeuueevkeevteegffehledtkeegudeigffgvdenucfkphepvdgrtddumegvtdgrmedvgeeimeejjeeltdemvdeitgegmegvvddvmeeitdefugemheekrgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemvdegieemjeejledtmedviegtgeemvgdvvdemiedtfegumeehkegrpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopehukhhlvghinhgvkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhto
 heplhhinhhugidqphifmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: herve.codina@bootlin.com

Hi Uwe,

On Wed, 5 Feb 2025 12:38:32 +0100
Uwe Kleine-König <ukleinek@kernel.org> wrote:

> Hello,
> 
> I really like this mechanism. Assuming the dt guys are happy yet, I
> intend to merge it. Just some detail question below.
> 
> On Wed, Feb 05, 2025 at 10:55:43AM +0100, Herve Codina wrote:
> > Nexus node support in PWM allows the following description:
> > 	soc {
> > 		soc_pwm1: pwm-controller1 {
> > 			#pwm-cells = <3>;
> > 		};
> > 
> > 		soc_pwm2: pwm-controller2 {
> > 			#pwm-cells = <3>;
> > 		};
> > 	};
> > 
> > 	connector: connector {
> > 		#pwm-cells = <3>;
> > 		pwm-map = <0 0 0 &soc_pwm1 1 0 0>,
> > 			  <1 0 0 &soc_pwm2 4 0 0>,
> > 			  <2 0 0 &soc_pwm1 3 0 0>;
> > 		pwm-map-mask = <0xffffffff 0x0 0x0>;
> > 		pwm-map-pass-thru = <0x0 0xffffffff 0xffffffff>;
> > 	};
> > 
> > 	expansion_device {
> > 		pwms = <&connector 1 57000 0>;
> > 	};  
> 
> Does this also work if &soc_pwm2 has #pwm-cells = <2>? Would I need just
> 
> 	pwm-map = <0 0 0 &soc_pwm1 1 0 0>,
> 		  <1 0 0 &soc_pwm2 4 0>,
> 		  <2 0 0 &soc_pwm1 3 0 0>;

Yes, exactly.

> 
> then and
> 
> 	pwms = <&connector 1 57000 0>;
> 
> would then have the same effect as
> 
> 	pwms = <&soc_pwm2 4 57000>

Yes, the last 0 (or any other values) in pwms = <&connector 1 57000 0> is
simply dropped in the translation (#pwm-cells = 3 in connector nexus to
#pwm-cells = 2 in soc_pwm1 node).

In more generic terms, it works in translation from #pwm-cells = N to
#pwm-cells = M by simply dropping the last N-M values.

Also note that even if values are dropped, you need to have them set when
you point the nexus node because #pwm-cells = 3 is set in the connector
node and need to be fixed and usable for all the entries in the
pwm-map table.

> 
> and the 0 is dropped then? Could I adapt the mapping that the effect is
> 
> 	pwms = <&soc_pwm2 57000 0>

In this one, I think you miss the PWM number
If I read correctly this line you ask for the PWM 57000 from the soc_pwm2
controller. This doesn't make sense :)

If I didn't answer already, can you clarify your point here ?
> 
> instead?


> 
> This smells a bit ugly and I wonder if this gives a motivation to extend
> the binding for PWMs that use #pwm-cells = <2> (or less) to also accept
> the default 3-cell binding.

With my understanding in the translation performed, this is not needed.

Also the following translation works:

	soc {
 		soc_pwm1: pwm-controller1 {
 			#pwm-cells = <2>;
		};

		soc_pwm2: pwm-controller2 {
			#pwm-cells = <3>;
		};
 	};

	connector: connector {
		#pwm-cells = <2>;   <--------- Note the 2 here
 		pwm-map = <0 0 &soc_pwm1 1 0>,
 			  <1 0 &soc_pwm2 4 0 123>,
 		pwm-map-mask = <0xffffffff 0x0>;   <---- #pwm-cells = <2> 
 		pwm-map-pass-thru = <0x0 0xffffffff>; <---- #pwm-cells = <2>
 	};

pwms = <&connector 1 57000> translates to pwms = <&soc_pwm2 1 57000 123>

The last value in the translation (i.e 123) was added during the translation
(#pwm-cells = <2> to #pwm-cells = <3>) from the value set in the pwm-map
table.

Hope I answered your questions.

Best regards,
Hervé

