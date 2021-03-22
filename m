Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7094B3449AE
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 16:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhCVPuj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 11:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhCVPuZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 11:50:25 -0400
X-Greylist: delayed 27213 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Mar 2021 08:50:24 PDT
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460BCC061574
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 08:50:24 -0700 (PDT)
Received: from antares.kleine-koenig.org (localhost [127.0.0.1])
        by antares.kleine-koenig.org (Postfix) with ESMTP id 4950CB3D085;
        Mon, 22 Mar 2021 16:50:22 +0100 (CET)
Received: from antares.kleine-koenig.org ([94.130.110.236])
        by antares.kleine-koenig.org (antares.kleine-koenig.org [94.130.110.236]) (amavisd-new, port 10024)
        with ESMTP id 1rkLMxZmoQTP; Mon, 22 Mar 2021 16:50:21 +0100 (CET)
Received: from taurus.defre.kleine-koenig.org (unknown [IPv6:2a02:8071:b5c8:7bfc:9c64:7e23:b041:2958])
        by antares.kleine-koenig.org (Postfix) with ESMTPSA;
        Mon, 22 Mar 2021 16:50:21 +0100 (CET)
Subject: Re: [PATCH v2 3/3] pwm: Drop function pwmchip_add_with_polarity()
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org
References: <20201207134556.25217-1-uwe@kleine-koenig.org>
 <20201207134556.25217-4-uwe@kleine-koenig.org>
 <YFiAaIIaOo6kBG0q@orome.fritz.box>
From:   =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Message-ID: <6eccf6a4-d410-bf30-fd0b-c1093cb6263a@kleine-koenig.org>
Date:   Mon, 22 Mar 2021 16:50:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFiAaIIaOo6kBG0q@orome.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="L0CLSk1cL5zZfoWZBRE1BU0CMKTzWpjSN"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L0CLSk1cL5zZfoWZBRE1BU0CMKTzWpjSN
Content-Type: multipart/mixed; boundary="sA25Pxf1hRLB9dJZuqs1ki1wnZnmKJkmJ";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org
Message-ID: <6eccf6a4-d410-bf30-fd0b-c1093cb6263a@kleine-koenig.org>
Subject: Re: [PATCH v2 3/3] pwm: Drop function pwmchip_add_with_polarity()
References: <20201207134556.25217-1-uwe@kleine-koenig.org>
 <20201207134556.25217-4-uwe@kleine-koenig.org>
 <YFiAaIIaOo6kBG0q@orome.fritz.box>
In-Reply-To: <YFiAaIIaOo6kBG0q@orome.fritz.box>

--sA25Pxf1hRLB9dJZuqs1ki1wnZnmKJkmJ
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Thierry,

On 3/22/21 12:32 PM, Thierry Reding wrote:
> On Mon, Dec 07, 2020 at 02:45:56PM +0100, Uwe Kleine-K=C3=B6nig wrote:
>> pwmchip_add() only calls pwmchip_add_with_polarity() and nothing else.=
 All
>> other users of pwmchip_add_with_polarity() are gone. So drop
>> pwmchip_add_with_polarity() and move the code instead to pwmchip_add()=
=2E
>>
>> The initial assignment to pwm->state.polarity is dropped. In every cor=
rect
>> usage of the PWM API this value is overwritten later anyhow.
>>
>> Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
>> ---
>>   drivers/pwm/core.c  | 25 +++----------------------
>>   include/linux/pwm.h |  2 --
>>   2 files changed, 3 insertions(+), 24 deletions(-)
>=20
> There was a conflict between this and patch "pwm: Always allocate PWM
> chip base ID dynamically", but it was fairly trivial to resolve. Let me=

> know if you think I didn't resolve it correctly.

You did it in the same way I did it on my next branch. (Actually I had=20
the patch order reversed, but the result is the same.)

Best regards
Uwe


--sA25Pxf1hRLB9dJZuqs1ki1wnZnmKJkmJ--

--L0CLSk1cL5zZfoWZBRE1BU0CMKTzWpjSN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBYvLYACgkQwfwUeK3K
7AlPggf/SFHdJlBAwEJr7TyCpMX3Zyep/eX0IkMc6qXWjOAaHkL+N0QkCf5o94Mi
UqgDlu50JSFFiF55wX/LPD6o57t5VQKWoWZDHlIxqSatvDtSD/LZ+MHK0oVy3tjD
8UaNJ+VWmPehS0n52onlkXJuUQa2e9ZEtWAJ6c7Pm41KfPFO44bw6c0lgIx47jEJ
tEl42cUk49J5zV743vSLf6aRpuuyeX+ahTL0r313dyGjs1n1A43ntmAQI6feRiLZ
qqsLK+Ms4QEwjFNA/cY4YWPTc1B6915a78eivK2SxCkmL/jbnwZnXd+Au45860Ry
DRDXStHYaJT9rMe3bKgok6F4UyOQCQ==
=GgcM
-----END PGP SIGNATURE-----

--L0CLSk1cL5zZfoWZBRE1BU0CMKTzWpjSN--
