Return-Path: <linux-pwm+bounces-5812-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6912AAA7320
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 15:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28104E0DB4
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 13:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8612254869;
	Fri,  2 May 2025 13:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O5G5HHbz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D0B254AEE;
	Fri,  2 May 2025 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746191740; cv=none; b=gCDNwDSMQFDRnoBsSWuK2Eev1yR7WA+1njYAV3OzoDT1MxAGLlzkFTuxac0TolHfGgXxmu3/PagZv/D1t4XnI5wLSPq560UUCbL0LvpDbnxkaaksERpQ2aEedhtS91Z5KCeIJP0f2vcv/J1y+Daq9CEqD1YRz+gh7eGmYzIxZ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746191740; c=relaxed/simple;
	bh=l6dshRg5SKm0QLRKQuxCti2pObhOW2+5/X5aezlQtn4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=YbNhF34w1KvmCM6Y8Sj9bljKpwGVCB3+0y7U+rjXrsHnGFfWgD/NzRmbTbEPCDE4vjIwhvI6iUR71yWae9jitGkGSE6khgFDpWkzzktWQyJoknrwTngoIyJIdf7/QRsbRD2e7Wx6nCDuxC/EEeTNeSSXO0R99TDuAxGcmdcjOjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O5G5HHbz; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A42D342D83;
	Fri,  2 May 2025 13:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746191735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/cWrrSzsINQ9rqSRtPa0XHYsGuJCfe/yw3Uo+Rflj8o=;
	b=O5G5HHbzdiyCDRrMoU+aw7ZBqMRBKXzSsfUjAAfQPQ1+teUClCIlU0hM7XiPYgSMuWtcSv
	ZAtvBsdD9LbydbSkhzcjJ7POGOkT3tF6E9Is3cIOoZtWfNoG0uLRVZovjqgRWuLkeFNPn5
	RI00CWNdB6j9h/5KDkmIMsDtPcrv0UdzzyhIEuwRbTAS3yhdoboxlLDs/MN7zi6jI+xXtU
	ws0UEFArTni5kS28UBGVenAuWEcKdevmY0+fnmozxZW8nAt677Z+n0Is3LDhj/t+aEwHkK
	KIHtTF30vz9WSM9lS3LlqshenE4d6av3tHgEiFU8S6zSHnLb1JSe9Xa39cfHoA==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 May 2025 15:15:34 +0200
Message-Id: <D9LPB49CQJDW.3VMFI0TFGV7K2@bootlin.com>
Subject: Re: [PATCH v7 09/11] input: keyboard: Add support for MAX7360
 keypad
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Michael Walle"
 <mwalle@kernel.org>, "Mark Brown" <broonie@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
 <20250428-mdb-max7360-support-v7-9-4e0608d0a7ff@bootlin.com>
 <aBSii0rHox72GM5Y@smile.fi.intel.com>
In-Reply-To: <aBSii0rHox72GM5Y@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfekieeftefhjeetveefudehuddvvdeuvddvudfgfffhveekffethfeuffdtudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Fri May 2, 2025 at 12:46 PM CEST, Andy Shevchenko wrote:
> On Mon, Apr 28, 2025 at 01:57:27PM +0200, Mathieu Dubois-Briand wrote:
>> Add driver for Maxim Integrated MAX7360 keypad controller, providing
>> support for up to 64 keys, with a matrix of 8 columns and 8 rows.
>
> ...
>
>> +static irqreturn_t max7360_keypad_irq(int irq, void *data)
>> +{
>> +	struct max7360_keypad *max7360_keypad =3D data;
>> +	struct device *dev =3D max7360_keypad->input->dev.parent;
>> +	unsigned int val;
>> +	unsigned int row, col;
>> +	unsigned int release;
>> +	unsigned int code;
>> +	int error;
>> +
>> +	do {
>> +		error =3D regmap_read(max7360_keypad->regmap, MAX7360_REG_KEYFIFO, &v=
al);
>> +		if (error) {
>> +			dev_err(dev, "Failed to read max7360 FIFO");
>> +			return IRQ_NONE;
>> +		}
>> +
>> +		/* FIFO overflow: ignore it and get next event. */
>> +		if (val =3D=3D MAX7360_FIFO_OVERFLOW)
>> +			dev_warn(dev, "max7360 FIFO overflow");
>
> If many events are missing this will flood the logs, perhaps _ratelimited=
() ?
>
>> +	} while (val =3D=3D MAX7360_FIFO_OVERFLOW);
>
> regmap_read_poll_timeout() ?
>

OK, I can try something like:

+       error =3D regmap_read(max7360_keypad->regmap, MAX7360_REG_KEYFIFO, =
&val);
+
+       /* FIFO overflow: ignore it and get next event. */
+       if (!error && (val =3D=3D MAX7360_FIFO_OVERFLOW)) {
+               dev_warn(dev, "max7360 FIFO overflow");
+               error =3D regmap_read_poll_timeout(max7360_keypad->regmap, =
MAX7360_REG_KEYFIFO,
+                                                val, val !=3D MAX7360_FIFO=
_OVERFLOW, 0, 0);
+       }
+
+       if (error) {
+               dev_err(dev, "Failed to read max7360 FIFO");
+               return IRQ_NONE;
+       }
+

Sleep_us is 0 as we are in the IRQ handler, but I'm not sure about
timeout_us. We could set one to make sure we are not stuck in the IRQ
handler, but the IRQ would fire again right after we return. I will stay
with 0 for now.

Also, the "max7360 FIFO overflow" message would be shown at most once
per IRQ, so probably no need for dev_warn_ratelimited().

>> +	if (val =3D=3D MAX7360_FIFO_EMPTY) {
>> +		dev_dbg(dev, "Got a spurious interrupt");
>> +
>> +		return IRQ_NONE;
>> +	}
>> +
>> +	row =3D FIELD_GET(MAX7360_FIFO_ROW, val);
>> +	col =3D FIELD_GET(MAX7360_FIFO_COL, val);
>> +	release =3D val & MAX7360_FIFO_RELEASE;
>> +
>> +	code =3D MATRIX_SCAN_CODE(row, col, MAX7360_ROW_SHIFT);
>> +
>> +	dev_dbg(dev, "key[%d:%d] %s\n", row, col, release ? "release" : "press=
");
>> +
>> +	input_event(max7360_keypad->input, EV_MSC, MSC_SCAN, code);
>> +	input_report_key(max7360_keypad->input, max7360_keypad->keycodes[code]=
, !release);
>> +	input_sync(max7360_keypad->input);
>> +
>> +	return IRQ_HANDLED;
>> +}
>
> ...
>

OK with other comments.

Thanks for your review.
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


