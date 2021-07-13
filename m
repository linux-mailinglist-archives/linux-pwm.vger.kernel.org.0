Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C33C3C6F21
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Jul 2021 13:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbhGMLJz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 13 Jul 2021 07:09:55 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:35220 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235813AbhGMLJz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Jul 2021 07:09:55 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-149-IVa75z0JOaOBrGaXpniqdQ-1; Tue, 13 Jul 2021 12:07:03 +0100
X-MC-Unique: IVa75z0JOaOBrGaXpniqdQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Tue, 13 Jul 2021 12:07:01 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Tue, 13 Jul 2021 12:07:01 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Russell King' <linux@armlinux.org.uk>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Salah Triki <salah.triki@gmail.com>,
        "fabrice.gasnier@foss.st.com" <fabrice.gasnier@foss.st.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] divide by 3*sizeof(u32) when computing array_size
Thread-Topic: [PATCH] divide by 3*sizeof(u32) when computing array_size
Thread-Index: AQHXd8hGdzQpdmgYHUiEx+VC3p1WwKtAvfwg
Date:   Tue, 13 Jul 2021 11:07:00 +0000
Message-ID: <012ccfea2a564274bd9d2e1cfc130873@AcuMS.aculab.com>
References: <20210712231910.GA1831270@pc>
 <20210713063053.qqttzxlopvpnadj3@pengutronix.de>
 <20210713091954.GG22278@shell.armlinux.org.uk>
In-Reply-To: <20210713091954.GG22278@shell.armlinux.org.uk>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Russell King
> Sent: 13 July 2021 10:20
....
> I would also note that the code relies on there being no padding in
> struct stm32_breakinput - it should be noted that a strict
> interpretation of the C standard allows padding to be added anywhere
> to a structure - at the start, end or between members.

I'm pretty certain I remember that padding before the first member
isn't allowed.

In any case the kernel generally assumes there is no extra padding.
(eg for structures that map hardware registers.)

For big structures it is worth adding a compile-time check of
the structure size - but not really for three u32.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

