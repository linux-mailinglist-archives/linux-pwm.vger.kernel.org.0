Return-Path: <linux-pwm+bounces-5308-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 314FAA762BB
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Mar 2025 10:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED90188A453
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Mar 2025 08:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5A71D5166;
	Mon, 31 Mar 2025 08:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Da+8Anil"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C3E15E5BB;
	Mon, 31 Mar 2025 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743410886; cv=none; b=YjKNvoBpae/hNrOB7d+jlC4S785Ipqsb9uIL4C8pClno6Xt11fFBLtOx69u70IbvYWEr7gw0dB3HN2ej8sfjGjS4Q5DADkxCjLDOf+QjH+2K9QvDNpiDL9INiY20RP+T7t+m3hSKbaxvJfbVreD+wQABDJVXreghkrbBoR7Wehk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743410886; c=relaxed/simple;
	bh=2Aph5r+ucMnFx8WbEX334zQY670ZD+b5koX2yPrT+io=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=FDVgHu9x/003iuN74lThMncmORPPExtOv3PksZteVDAk2FcyrRfyQwFUAsxUJ2DbOWHINJ3xm84UO+WOw/KmQUJThL93CumDYiveyGRDsjYyxJauXXKNJ2JsFBJy9qzH3GWCzQOkzSgXGyoeLjaMJ7uPA6e59pUgrAww3xea3G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Da+8Anil; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B7BF62047D;
	Mon, 31 Mar 2025 08:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743410881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9aErTBB6XoGeVcpJbLF45VHi7cVLHU979KcrvGo1E0c=;
	b=Da+8Anilt9Neby3nnfgRhzL9gqecwhYWYFRvTUXHkG/WEhbCA8z2Nr6aa6Kgpl+qrvfyDE
	NoFKL/KBHHpdjYgv9CMUgWPAWDfu5HgkOezzhxKYANUYZGjhME8NPMRmQ7ONyXwXI6RJrl
	g1+n1eBUZCndKJsxD5o4le4STCDdyT5ePYRiyidUKAlnJI4nKq1frCwgH3yEWStwbsi1FJ
	SBcTvjfhPkeSbMz7ou3CL4jxggXzGcq6smV3uqkEeAk54/sjpl2gj/M896x0JKwXM61NrT
	jk3MFf1aqSK5sGQBou9eV+sjb925zqptuFAe7E5ygQ8knVEN2egtCwfWbR1p1w==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Mar 2025 10:47:59 +0200
Message-Id: <D8UBKT8USZ4U.1OOL1IJMPECFE@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>, "Lee Jones"
 <lee@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Kamel Bouhara"
 <kamel.bouhara@bootlin.com>, "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Michael Walle" <mwalle@kernel.org>, "Mark Brown"
 <broonie@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>
Subject: Re: [PATCH v5 01/11] dt-bindings: mfd: gpio: Add MAX7360
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <andriy.shevchenko@intel.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-1-fb20baf97da0@bootlin.com>
In-Reply-To: <20250318-mdb-max7360-support-v5-1-fb20baf97da0@bootlin.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelgeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkhffvufevofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehvedtkeffueelheektddvjefhiefhgedtudevgeehvdevlefgveetkeevleelteenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhgvvgesk
 hgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Tue Mar 18, 2025 at 5:26 PM CET, Mathieu Dubois-Briand wrote:
> Add device tree bindings for Maxim Integrated MAX7360 device with
> support for keypad, rotary, gpios and pwm functionalities.
>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---

Hi,

Following discussion we had under the PWM patch of this series, we might
need to refactor a bit the device tree binding architecture, adding two
new subnodes, one for pinctrl and one for PWM.

This will need create two new compatible values with associated bindings
and modify a bit the properties of the maxim,max7360.yaml binding.

Here is the example modified to reflect what I have in mind.

> ...
>
> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max7360.yaml b/D=
ocumentation/devicetree/bindings/mfd/maxim,max7360.yaml
> new file mode 100644
> index 000000000000..d3c09531dc5c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/maxim,max7360.yaml
> @@ -0,0 +1,170 @@
>
> ...
>
> +examples:
> +  - |
> +    #include <dt-bindings/input/input.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      io-expander@38 {
> +        compatible =3D "maxim,max7360";
> +        reg =3D <0x38>;
> +
> +        interrupt-parent =3D <&gpio1>;
> +        interrupts =3D <23 IRQ_TYPE_LEVEL_LOW>,
> +                     <24 IRQ_TYPE_LEVEL_LOW>;
> +        interrupt-names =3D "inti", "intk";
> +
> +        keypad,num-rows =3D <8>;
> +        keypad,num-columns =3D <4>;
> +        linux,keymap =3D <
> +          MATRIX_KEY(0x00, 0x00, KEY_F5)
> +          MATRIX_KEY(0x01, 0x00, KEY_F4)
> +          MATRIX_KEY(0x02, 0x01, KEY_F6)
> +          >;
> +        keypad-debounce-delay-ms =3D <10>;
> +        autorepeat;
> +
> +        rotary-debounce-delay-ms =3D <2>;
> +        linux,axis =3D <0>; /* REL_X */
> +

+ max7360_pwm: pwm {
+         compatible =3D "maxim,max7360-pwm";

> +        #pwm-cells =3D <3>;

+ };

> +
> +        max7360_gpio: gpio {
> +          compatible =3D "maxim,max7360-gpio";
> +
> +          gpio-controller;
> +          #gpio-cells =3D <2>;
> +          maxim,constant-current-disable =3D <0x06>;
> +
> +          interrupt-controller;
> +          #interrupt-cells =3D <0x2>;
> +        };
> +
> +        max7360_gpo: gpo {
> +          compatible =3D "maxim,max7360-gpo";
> +
> +          gpio-controller;
> +          #gpio-cells =3D <2>;
> +        };

+ pinctrl {
+         compatible =3D "maxim,max7360-pinctrl";

> +
> +        backlight_pins: backlight-pins {
> +          pins =3D "PORT2";
> +          function =3D "pwm";
> +        };

+ };

> +      };
> +    };

This would allow to assign a device tree node to both the pinctrl and
the PWM devices in the kernel?

Is there any comment regarding this proposal? Without any specific
comment, I will send a new version with these changes in a few days.

Best regards,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


