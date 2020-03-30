Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6626197FE6
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2020 17:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgC3Pkl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Mar 2020 11:40:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53956 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgC3Pkk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 11:40:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id b12so20450354wmj.3;
        Mon, 30 Mar 2020 08:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=99cdCKyzlQP4RWOd0m1fQdSkizE4aNR1vgJy5iIbCIw=;
        b=jT//Djhc0VNAIyW7Bfo7EIbncRnKPxwZ5vQhgdOj6wPNw0w4wjBvGITbjgnueprGPl
         CWGHr0POC8zGlOZZ6fn1kimKEKFZWJdKMqVlfiHsaekXSyH8cE/m+bQhya3zW26Qg6h3
         RqiWmOfF1UcokHqpyhTg+lyllrjULXCUXqqssi/5GNp2Ih247jIXMmiM+xwiSZHJXgkE
         SAQjTE4lYKqmPRcNYBXhehfNXF/dEnTy8qwoLcOd5myhA1N3OOyIs/eQty3m5Q9BBLIb
         dGRa9Gu4xUWtKIQMO9S4ORL3H1AIqHXry2btdfhhLKkMxyXN6AIwhfGKHERHsnz3Lc3b
         N2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=99cdCKyzlQP4RWOd0m1fQdSkizE4aNR1vgJy5iIbCIw=;
        b=WaZof2SkhSBJyVVnYz74LpslrwRTu3mctoDOzi8QaT3yNg27l7hBZG9eijRVRO0DnZ
         srBtulvHxr9wm2ALIgvFanxXPychBPMwYJw9Xbv1IC8YAerLOp34GwNYS/uWvG9dEBHm
         VtqJmIRPNEHDOjTZ/3xAVxp51bVO3jQyTN/ZURbQiovex71SHfe8UDvEzsQ7vq6Y9NKq
         6qmJtAbqzK1SQL91YtzB56XAS/8++Ui83QBzPX445g6RXe28qZURYKtF0hmBwXu4LnNB
         3aQJY/kYvlp3kFL8bL1gdnMsv6fwc5/VwxtOP//HZsOnW0+tqL0856nzwTdfO72DXx+E
         MYlg==
X-Gm-Message-State: ANhLgQ1YJOwQvSKchX8cW6N0HrpVdFIyrrESsq4emxjUEJVQZX8QFaEq
        wM1evqlVtaWvymoWl88qkQE=
X-Google-Smtp-Source: ADFU+vtt2HE6dnDVDzW0bv3OYJOw4oJaxHZQ15/r8ksluuyQdwqI18mmdzKmB84t09eQeSkmbtoeSg==
X-Received: by 2002:a05:600c:2294:: with SMTP id 20mr13425526wmf.130.1585582839116;
        Mon, 30 Mar 2020 08:40:39 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id v11sm22903550wrm.43.2020.03.30.08.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 08:40:37 -0700 (PDT)
Date:   Mon, 30 Mar 2020 17:40:36 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH 2/4] pwm: pca9685: remove ALL_LED PWM channel
Message-ID: <20200330154036.GB2817345@ulmo>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226135229.24929-2-matthias.schiffer@ew.tq-group.com>
 <20200330130757.GC2431644@ulmo>
 <20200330133450.GA1530@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <20200330133450.GA1530@workstation.tuxnet>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2020 at 03:34:50PM +0200, Clemens Gruber wrote:
> Hi,
>=20
> On Mon, Mar 30, 2020 at 03:07:57PM +0200, Thierry Reding wrote:
> > On Wed, Feb 26, 2020 at 02:52:27PM +0100, Matthias Schiffer wrote:
> > > The interaction of the ALL_LED PWM channel with the other channels was
> > > not well-defined. As the ALL_LED feature does not seem very useful and
> > > it was making the code significantly more complex, simply remove it.
> > >=20
> > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > > ---
> > >  drivers/pwm/pwm-pca9685.c | 115 ++++++------------------------------=
--
> > >  1 file changed, 17 insertions(+), 98 deletions(-)
> >=20
> > Applied, thanks.
> >=20
> > Thierry
>=20
> I was not reading the mailing list in the last weeks, so I only saw the
> patch today.
>=20
> We are using the ALL_LED channel in production to reduce the delay when
> all 16 PWM outputs need to be set to the same duty cycle.
>=20
> I am not sure it is a good idea to remove this feature.

Can you specify what platform this is and where the code is that does
this. I can't really find any device tree users of this and I don't know
if there's a good way to find out what other users there are, but this
isn't the first time this driver has created confusion, so please help
collect some more information about it's use so we can avoid this in the
future.

I'll back out this particular patch since you're using it. Can you give
the other three patches a try to see if they work for you?

Thierry

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6CEvQACgkQ3SOs138+
s6EB/w/9FDGfvq1biq0AqLk1jc2iemdcmBqomC0BRENdlU/leyP5qoI41XFsa8Da
TFYA+/4LD/3wfiT0wG9bwUxNIaywETrZgNFW/Ps2lahE/QbtDGNO05E/2hs3Lsjt
3KHzYiCpC4Bgz3prl/lHhQEfqyV2lZABA19+JG/Xn6+4iIWBn5dl2eJDpRH60Fcn
AWnReeAqSs/dhsH010bpF9UVgenqTYM4/N6S5L+EsJ4MuDIpCEaHtLXTUCcnGVIS
ZCi8CRXSLS1Hr1P1sXtrCri9SJyV4AjI/eWVsDL9D2JJINAO2L6Gy3PhkN9IBa+t
t2OocGZ3IdrVpvgJs5g7ji0OFkbnJof67i7SrUpgZy9kFhrrc7pMdcM72jIKo7GE
V6n5SZIoWuAuyX4fKh+tKDEsVJ56j6t/+JS6s/ipg5X0SZMp4+NLX1pjiU3nij6/
3orBfvt/xt/xOqFpdp9e3m4MeiH3y06VjE77ih9uP3LXM7ZS//XCG4SVNOEn6VEd
RJoJ37zawE9BiTrjmU1fhgzzJBlMoMkwff8OyTOpC+bTPldKeOxUzj7aNgjdiIkJ
rgfjUPFzezEdTXd/u/PpFR5soC1c3g3y1WFumNzdCDoq04jZO2PBdu4GSrcCxuBq
QGiSG4veVm1jtfo4VSaLrptJXpk5jsgg4qxhj3Encnbhq3o5Sto=
=96AW
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
