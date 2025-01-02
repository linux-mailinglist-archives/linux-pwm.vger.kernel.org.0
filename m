Return-Path: <linux-pwm+bounces-4532-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D6E9FF77D
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Jan 2025 10:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA233A2D38
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Jan 2025 09:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302F319DF98;
	Thu,  2 Jan 2025 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TiiAF6VW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A889119D086;
	Thu,  2 Jan 2025 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735810497; cv=none; b=VCtCygLF2Ywu82xAlFegXzjt6hJrDinJ/rrl8Z+84IkNWvGJ4UOIwVDztOApK+dg3Et23UVCZ5KhPxPxWVLei9nunc9mfCkJgvcmB+pygTU0PxWV5+4lsm4x10gHdTXl8ZKhS7gw+FAVnjfKwzm7HDpUruoVHHFT1X3gxcyLXrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735810497; c=relaxed/simple;
	bh=c9rKsDiha9fDzMuda3rAARdYRSPn+SADWPbuqHkSGHc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=Dv3/cB1ywrYXmGbzfBFSsFyY4vv1bKd1G+Voh3kWvjtJtsyQEjrdtguUC6FNSa+Of2XI1/M1Yc6z4t8bhYR3VoSIKXiaQxFUJPWSjQEYSoDARPs7P2BRkN/wY9QtxdmnT2hl3mnI9vOYPzZaP/C/fNrzcoxiQZA90fZm9Wkkm3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TiiAF6VW; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8E22420003;
	Thu,  2 Jan 2025 09:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735810486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c9rKsDiha9fDzMuda3rAARdYRSPn+SADWPbuqHkSGHc=;
	b=TiiAF6VWtPQVkrPAtL9JJV9BDB/vJsfLqzPNQtIO+wziyhGWec66ocbGpw17yolmpeoSED
	U+eRaNjQGVGJ3catMlDCBujqSGIrbyG9XX7Dq7MzE2Nw233fIbckgh9aJTKNKoZPJc7bDb
	7zqeQqkJftEc86xlkQsjsAAb0vJ//pfb+Ftekn7SIDBDo7hK6G6BWrsoUcRHo1LyquEHOF
	izQEXGfej+M52B1712QJGKk72JWsIqpcNowKwmtTcTPK3lwfJeWYt30U0SNc5Z/vI0+nzR
	ZlW0SRnp2WjEAJ3KvO8dN8Am5cBcZahPVxeVBIa8p644pc0rqtqEguJqzBx2nw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jan 2025 10:34:45 +0100
Message-Id: <D6RHGOGA0PL5.147OW8IBT7NKY@bootlin.com>
Subject: Re: [PATCH v2 6/7] input: misc: Add support for MAX7360 rotary
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>, "Lee Jones"
 <lee@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Kamel Bouhara"
 <kamel.bouhara@bootlin.com>, "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241223-mdb-max7360-support-v2-0-37a8d22c36ed@bootlin.com>
 <20241223-mdb-max7360-support-v2-6-37a8d22c36ed@bootlin.com>
 <d3174dce-868c-4a42-9a5c-2b947ae88d18@wanadoo.fr>
In-Reply-To: <d3174dce-868c-4a42-9a5c-2b947ae88d18@wanadoo.fr>
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Tue Dec 31, 2024 at 6:49 PM CET, Christophe JAILLET wrote:
> Le 23/12/2024 =C3=A0 17:42, Mathieu Dubois-Briand a =C3=A9crit=C2=A0:
> > Add driver for Maxim Integrated MAX7360 rotary encoder controller,
> > supporting a single rotary switch.
> >=20
> > Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com=
>
>
> ...
>
>
> CJ

Hi Christophe,

Thanks a lot for all your comments. I've integrated fixes for all of
them, to be shipped with the next version.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


