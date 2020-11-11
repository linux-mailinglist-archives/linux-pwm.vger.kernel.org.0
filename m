Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560B42AF93E
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Nov 2020 20:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgKKTnm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Nov 2020 14:43:42 -0500
Received: from antares.kleine-koenig.org ([94.130.110.236]:44962 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgKKTnk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Nov 2020 14:43:40 -0500
Received: from antares.kleine-koenig.org (localhost [127.0.0.1])
        by antares.kleine-koenig.org (Postfix) with ESMTP id D8FC1A79A0D;
        Wed, 11 Nov 2020 20:43:29 +0100 (CET)
Received: from antares.kleine-koenig.org ([94.130.110.236])
        by antares.kleine-koenig.org (antares.kleine-koenig.org [94.130.110.236]) (amavisd-new, port 10024)
        with ESMTP id uNdN9n5f0VRG; Wed, 11 Nov 2020 20:43:24 +0100 (CET)
Received: from taurus.defre.kleine-koenig.org (unknown [IPv6:2a02:8071:b5ad:20fc:cb6e:4363:d5b7:2207])
        by antares.kleine-koenig.org (Postfix) with ESMTPSA;
        Wed, 11 Nov 2020 20:43:23 +0100 (CET)
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Ajit Pal Singh <ajitpal.singh@st.com>,
        linux-pwm@vger.kernel.org
References: <20201013081531.661528-1-uwe@kleine-koenig.org>
 <20201106082914.GX4488@dell> <20201106093435.4mlr6ujivvkzkd5z@pengutronix.de>
 <20201106102908.GC2063125@dell> <20201111192823.GD6125@ulmo>
From:   =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH] pwm: sti: fix error handling
Message-ID: <0d9adfa9-9015-c8c5-c21a-f4ad9b1ef7a9@kleine-koenig.org>
Date:   Wed, 11 Nov 2020 20:43:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201111192823.GD6125@ulmo>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lr1ni7kJb1eu4AqG2VYY0XVgD62jFgL8O"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lr1ni7kJb1eu4AqG2VYY0XVgD62jFgL8O
Content-Type: multipart/mixed; boundary="p2xpuSLnqxyRGmJwemu1IwC0bhtNA6rzO";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Thierry Reding <thierry.reding@gmail.com>,
 Lee Jones <lee.jones@linaro.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Ajit Pal Singh <ajitpal.singh@st.com>, linux-pwm@vger.kernel.org
Message-ID: <0d9adfa9-9015-c8c5-c21a-f4ad9b1ef7a9@kleine-koenig.org>
Subject: Re: [PATCH] pwm: sti: fix error handling
References: <20201013081531.661528-1-uwe@kleine-koenig.org>
 <20201106082914.GX4488@dell> <20201106093435.4mlr6ujivvkzkd5z@pengutronix.de>
 <20201106102908.GC2063125@dell> <20201111192823.GD6125@ulmo>
In-Reply-To: <20201111192823.GD6125@ulmo>

--p2xpuSLnqxyRGmJwemu1IwC0bhtNA6rzO
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On 11/11/20 8:28 PM, Thierry Reding wrote:
> I agree with Lee on this one, so I've applied the patch and touched up
> the label names while at it.

Have you tried to follow my reasoning? I consider it irritating that you =

overrule the preference I justified in such detail by applying a patch=20
with me as author and the error handling variant I opposed to.

Uwe


--p2xpuSLnqxyRGmJwemu1IwC0bhtNA6rzO--

--lr1ni7kJb1eu4AqG2VYY0XVgD62jFgL8O
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+sPtYACgkQwfwUeK3K
7AljlQf/bYSxdzPwJmdy4fsyBxfQTqmHq+zphfrpjeImw5+IqTIaFBdfvhiCsRbD
+cdSf0/kagaGJPk+ZhbLf/fuGeCX9b44B518x00/QYjGx2YW5bq+ksVU7ly4YnRt
DLaZ5X8sUNz0lyFTrWCvoDK5oECUjFkz8nGN8MwuUCyv9QBMEFB5F4DRbr4gqEhv
7ponfpqcyiHh1ETGoUyCVnDq6NOwJELPCor2QQgCIM9pIseOVVL1KOA2VQcmf8YW
N11aygymEhU7uhq/6JtOLyyomYxjKvqfdeMcP5lGIjkw3ooB/Husum5QQctj5SKy
Tq0dTbdqc5P1dvKKwReEApKmKzRG7w==
=rzEm
-----END PGP SIGNATURE-----

--lr1ni7kJb1eu4AqG2VYY0XVgD62jFgL8O--
