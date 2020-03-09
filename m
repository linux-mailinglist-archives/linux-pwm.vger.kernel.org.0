Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA3CE17E047
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Mar 2020 13:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgCIMaH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Mar 2020 08:30:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgCIMaH (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 9 Mar 2020 08:30:07 -0400
Received: from earth.universe (dyndsl-095-033-170-219.ewe-ip-backbone.de [95.33.170.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83EA02072A;
        Mon,  9 Mar 2020 12:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583757006;
        bh=diq25L1IPlx433ZM3VoDc5SJPfrMcgY8a1nf8LbuVPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y11VkzV4imOBaLXieqJLXLqJyBpp8d3exizNybEUy/71PcBs+5HBbLVQ7LHhqQVo1
         axJkhGWGL45ws/yvks/CkQ2muH41PHWRXnZbFdHIMei2VIbZfG4fdh5PFtWFl0rICo
         ZCLF/27wogqmRkos2xg99GZ8weKkUqKlTGhD7puM=
Received: by earth.universe (Postfix, from userid 1000)
        id 6652D3C0C82; Mon,  9 Mar 2020 13:30:02 +0100 (CET)
Date:   Mon, 9 Mar 2020 13:30:02 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v2 4/6] pwm: omap-dmtimer: Fix pwm disabling sequence
Message-ID: <20200309123002.dy3jqqcm2us4ygpo@earth.universe>
References: <20200228095651.32464-1-lokeshvutla@ti.com>
 <20200228095651.32464-5-lokeshvutla@ti.com>
 <20200306181443.GJ37466@atomide.com>
 <9129d4fe-a17e-2fa6-764c-6a746fa5096d@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eosgsryqn2a77iww"
Content-Disposition: inline
In-Reply-To: <9129d4fe-a17e-2fa6-764c-6a746fa5096d@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--eosgsryqn2a77iww
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 09, 2020 at 10:21:59AM +0530, Lokesh Vutla wrote:
> > [0] https://git.collabora.com/cgit/user/sre/rumble-test.git/plain/rumbl=
e-test.c
>=20
> This is redirecting to collabora.com. Is this code available in github or=
 some
> public repo?
>=20
> Thanks and regards,
> Lokesh

Sorry, we migrated to gitlab under different domain. I pushed it
here now: https://github.com/sre/rumble-test

-- Sebastian

--eosgsryqn2a77iww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl5mNrIACgkQ2O7X88g7
+ppmFRAAmZJVN7L3IfK3pDbnpFFcwSlwwZC88ezxxQML6+PgbESuKJ/ku3Y1JQ6T
FYJzl25NvaMjPWKKXrPhMhd08J3nY08OerY/R6g6jJ3YktXuDN93EScwlOQ4Lifq
+lW7gB8GLh23ddSdVuzoPv55/8/rAsBGpwj1MFLddSJvtSC6KDKqd+ZO1+/W5kK5
d+6ZtPrLTEwBC7jC4swzTRYGKWgqTitulTloq9snCMoa7lerisacaplmv0L7G3Mp
MhnLhyrYvw9p5X8JK6Is+BkMctlTgMaq75jXZ5tj+YMY17+9tAOyfdzQnmeJVsUq
hZjcyqHWCX3HWYQdjQONG/4Yxrgz64mlyYARzm9hoREPdvLpUyRtGpDlJtHDw6u6
8XkAeIdVn6FKbm+WT2dTDGju4W7GN4kUs9VvF4enwVX4clYO2VMvtOIkP9BSWZUZ
6ODkheoCultJGLEmTnnO+b86cclhPb3c/S2qqnZz3K4jH7kJH+V5CGc057R/FDKC
NeREUSbYo0dIujnEq3i0+NmsTaEkB5a47Z2+gfKrvkbM3uRXzKsBmunGnoy1BHxh
rLjLn+BdqAHAgx2OsU3UVWi34It7Av7mzdoRohJEleXUPmT6SRHmR6PpNM0yicM/
qyJ6gCH51Q4lwEQ2ro24fyc2V3w0TK/BFat2M0WC3w3z0FnMWOQ=
=MhfD
-----END PGP SIGNATURE-----

--eosgsryqn2a77iww--
