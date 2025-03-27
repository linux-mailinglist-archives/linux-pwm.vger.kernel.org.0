Return-Path: <linux-pwm+bounces-5295-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0C1A7345C
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Mar 2025 15:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34FD172DBE
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Mar 2025 14:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AAB217737;
	Thu, 27 Mar 2025 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IqwuBRNy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D2642AA1;
	Thu, 27 Mar 2025 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743085695; cv=none; b=lpiOX68yglvO6xwcy305JxbMlyeqvtBavobub3UI6LgpCCixkzSXexgzkt6g65v1PSz9Jx1a6MIp4BcPyZCL4d6p60EP2bZad8p3oM2pt29aRshjGYpcrUL+hQvZx2DA7+RnllEdcu5rOhF2PngawDm8PlDb4ppXoiKju3cfDag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743085695; c=relaxed/simple;
	bh=9CrKK6cIee4YnDPya25QS1ETKuZvPVbxmWE9N6/dhh0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=Enydjp/rPI3zIbOH87DZnKER3uqoIy2lOJK/kW/4Q2q68d1lI3yHyAXuTd1pxU8pAoDfa3A/j9xjcPY644dmxwGpKCAt8ooyfAuxbNx0iXZdfhR/wNfTLn73Rtj3U09yYTiE29ENTw69IfSGlrVhMbWRFE0q5EYFL+iXd+ukAt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IqwuBRNy; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2DFFF4333F;
	Thu, 27 Mar 2025 14:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743085690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qHbjzZHIWdF+oJ+tIyzeK9jgZa7NadpudWM3f7DicPI=;
	b=IqwuBRNyA4E0gslvSstg36KzfFTokLev68oyPz0MzCj/JzXu2DJkHIGq5rXA1xZmzd1VBu
	0LPHI3KMhedExRlsC9GVOpgkW4LjhnIzk5K0M3SOBUjBiSJQdA6K7B31QiOx2upEp5Qv3+
	O+t1HTHsUb/8XEEIToMeedsDrKm3lYtDjcXTY6sQ8X9DqCcPuWDHDHXJKn1QtTXBR972WA
	dvkI3XsuMWds/u9MsuWKyjoV0wP/HmigOyg5AXDW8Yg60toupM2/kni4hWHzuQaEDt9GPe
	gH0+bpbK2aRAbbe/gc5nczrBRskIXMRW4D2rKnonQy+6XaEf+zFR1cwMxQi3iw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Mar 2025 15:28:08 +0100
Message-Id: <D8R4B2PKIWSU.2LWTN50YP7SMX@bootlin.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Lee Jones"
 <lee@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Kamel Bouhara"
 <kamel.bouhara@bootlin.com>, "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Michael Walle" <mwalle@kernel.org>, "Mark
 Brown" <broonie@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 04/11] pwm: max7360: Add MAX7360 PWM support
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-4-fb20baf97da0@bootlin.com>
 <Z9qoGmNKcozbIjeH@smile.fi.intel.com>
 <hinocg3itjqizbmzgaxv6cfnhtus6wbykouiy6pa27cxnjjuuk@l5ppwh7md6ul>
 <Z9vydaUguJiVaHtU@smile.fi.intel.com>
 <D8PF958QL5AK.2JIE4F1N1NI0F@bootlin.com>
 <Z-LSHoYA1enEOeHC@smile.fi.intel.com>
 <D8QA116WPNUE.11VKIHSG9N0OZ@bootlin.com>
 <Z-Qh8yBMaCMhv_Ny@smile.fi.intel.com>
In-Reply-To: <Z-Qh8yBMaCMhv_Ny@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekieehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvefhvffuofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeftedvgfegteehjeejtdefgffhteevvddtvdejleeghfefuefgledtteduvdetkeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtohepuhhklhgvihhnvghksehkv
 ghrnhgvlhdrohhrghdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghmvghlrdgsohhuhhgrrhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhg
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Wed Mar 26, 2025 at 4:49 PM CET, Andy Shevchenko wrote:
> The use of this API is inappropriate here AFAICT. It drops the parent ref=
count
> and on the second call to it you will have a warning from refcount librar=
y.
>
> It should be as simple as device_set_node().
>
> >         }
>
> With that, the conditional becomes
>
> 	} else if (is_of_node(fwnode)) {
> 		device_set_node(&pdev->dev, fwnode);
> 	}
>
> where fwnode is something like
>
> 	struct fwnode_handle *fwnode =3D dev_fwnode(parent);

Hi,

I tried to use device_set_node(), but then I got some other issue: as we
now have several devices with the same firmware node, they all share the
same properties. In particular, if we do use pinctrl- properties to
apply some pinmmuxing, all devices will try to apply this pinmuxing and
of course all but one will fail.

And this makes me think again about the whole thing, maybe copying the
fwnode or of_node from the parent is not the way to go.

So today we rely on the parent node for four drivers:
- keypad and rotary, just to ease a bit the parsing of some properties,
  such as the keymap with matrix_keypad_build_keymap(). I can easily do
  it another way.
- PWM and pinctrl drivers, are a bit more complicated, as in both case
  the device tree node associated with the device is used internally. In
  one case to find the correct PWM device for PWM clients listed in the
  device tree, in the other case to find the pinctrl device when
  applying pinctrl described in the device tree.

So maybe I have to find a better way for have this association. One way
would be to modify the device tree bindings to add a PWM and a pinctrl
node, with their own compatible, so they are associated to the
corresponding device. But maybe there is a better way to do it.


--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


