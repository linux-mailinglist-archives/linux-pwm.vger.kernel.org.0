Return-Path: <linux-pwm+bounces-5486-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18754A89C5A
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 13:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0693A35FD
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 11:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1132C291170;
	Tue, 15 Apr 2025 11:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HeGPgQ8o"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3974729B77F;
	Tue, 15 Apr 2025 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744716248; cv=none; b=QflVahoMdoEpFOZScLlFIfLUC8L92DbMlo9bkJ6akDB3/E+80LDGYSM/vexyNtoMxfA9/1UtQ/qALLvUj6HDyshzWsZQcGKjwr33Z+UFCBocpPs1Jt0NPfNcvpUE8fLJMe26Ah4DATbs5JoLY3RCXKhaivC4lhqBiKi4CvqDQW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744716248; c=relaxed/simple;
	bh=QukepWGkmiY8zzaTK1fbsDNX7XQXCUloyqOgRjHkJpw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=ZUpW7S1g1vC0psi61zlM0eJOHhZQMoxn8VD8gZLjVp6lYnXGz9+Sgnwpokdvb57p0H+gY2anO4EpB/4YSUxjjUnFENI9d2KBOUht0kTugwqyr8LxeXiSfgQY21cUt7YBSsTQjpsFCmyNu+Q7YXwPsnsH7l7skvDeQT8AuoCUmlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HeGPgQ8o; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 354374396A;
	Tue, 15 Apr 2025 11:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744716243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TxIOFEfqRfalUhnO+3adQ/Ty52ZIx6maGadY9jlzhgA=;
	b=HeGPgQ8o46y1Vexb6QEfjHrHBgrp7c6Xd4Kep0LYNXFmKMbUUmMr7A/bMKPewc0MEUvF+T
	X6NzqkGsg/I92lYZF0FBU7eMlhqFicO+QbSnBePTOvT0Veow0FCVEmbtpGD75XcWCc1IyE
	ht/4mGWFR0XWRAxSYJCNC7uy2YWEf5sWSGkjiSsVzRpqdIfOipBKRQU4hkQsiy8i7u0Pn+
	YoArr6lSPO3j44euWUTahsAlxJUltpkiskrp1ROTDOvGz8BkelUOALZadFOZmdhXGOqw25
	813LAAqqgLHRtW+0BH6y0SmAGX3hqqa4d/Jl+anIpDbPiD+ss7CdudcRC2elHQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Apr 2025 13:24:01 +0200
Message-Id: <D976AGJAXE3S.1AUQ47D8Q28SG@bootlin.com>
Subject: Re: [PATCH v6 01/12] dt-bindings: mfd: gpio: Add MAX7360
Cc: "Linus Walleij" <linus.walleij@linaro.org>, "Lee Jones"
 <lee@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 <andriy.shevchenko@intel.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Kamel Bouhara"
 <kamel.bouhara@bootlin.com>, <linux-kernel@vger.kernel.org>, "Michael
 Walle" <mwalle@kernel.org>, <linux-pwm@vger.kernel.org>, "Bartosz
 Golaszewski" <brgl@bgdev.pl>, "Danilo Krummrich" <dakr@kernel.org>, "Mark
 Brown" <broonie@kernel.org>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, <linux-gpio@vger.kernel.org>,
 <linux-input@vger.kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 <devicetree@vger.kernel.org>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-1-7a2535876e39@bootlin.com>
 <174438751337.3319673.5204335405880872375.robh@kernel.org>
In-Reply-To: <174438751337.3319673.5204335405880872375.robh@kernel.org>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeffeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfekieeftefhjeetveefudehuddvvdeuvddvudfgfffhveekffethfeuffdtudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhor
 hhgpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtohepuhhklhgvihhnvghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Fri Apr 11, 2025 at 6:05 PM CEST, Rob Herring (Arm) wrote:
>
> On Wed, 09 Apr 2025 16:55:48 +0200, Mathieu Dubois-Briand wrote:
>> Add device tree bindings for Maxim Integrated MAX7360 device with
>> support for keypad, rotary, gpios and pwm functionalities.
>>=20
>> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>> ---
>>  .../bindings/gpio/maxim,max7360-gpio.yaml          |  83 ++++++++++
>>  .../devicetree/bindings/mfd/maxim,max7360.yaml     | 171 ++++++++++++++=
+++++++
>>  2 files changed, 254 insertions(+)
>>=20
>
> With the typos fixed,
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Thanks for the tag!

As a quick note, I believe the bindings will be slightly modified in
next version, to address requests on the rotary encoder driver:

--- c/Documentation/devicetree/bindings/mfd/maxim,max7360.yaml
+++ w/Documentation/devicetree/bindings/mfd/maxim,max7360.yaml
@@ -54,6 +54,17 @@ properties:
   linux,axis:
     $ref: /schemas/input/rotary-encoder.yaml#/properties/linux,axis

+  rotary-encoder,relative-axis:
+    $ref: /schemas/input/rotary-encoder.yaml#/properties/rotary-encoder,re=
lative-axis
+    description:
+      Register a relative axis rather than an absolute one.
+
+  rotary-encoder,steps:
+    $ref: /schemas/input/rotary-encoder.yaml#/properties/rotary-encoder,st=
eps
+
+  rotary-encoder,rollover:
+    $ref: /schemas/input/rotary-encoder.yaml#/properties/rotary-encoder,ro=
llover
+
   "#pwm-cells":
     const: 3


Best regards,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


