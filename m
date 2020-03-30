Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44C37197CA2
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2020 15:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbgC3NQB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Mar 2020 09:16:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40942 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730192AbgC3NQB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 09:16:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id u10so21559464wro.7;
        Mon, 30 Mar 2020 06:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VGcf5Y3br1ZN5VCsPF1qnkiLgAjNrdQuMuRN5l4Pvao=;
        b=WcPY6bXGUtrqK29GdrJLzVQKsEUNxf6CZtZNDnVxzJWOjk48gxdrUrBmiiBU9KZoKu
         iU+GjFa/4Dt8hTJOzc4f9T7PoxTBEQs37M+4LA74vM7pjtTLg25Vqe7+HdfKYyCWuYRc
         scvbS7King5krfP/ccSLX5xuzv2u3o0InqqHlYCsGConLttzaDpgzvD5PDTtSjYHXuj9
         TDjPjUirfIM9VTfRKF4b6nPBPnzQ8bN6RES+wo2r0UD+dGl3yCx19kTXkCp7wEeK1+Dm
         Ei9gjtzYaL9HSx/Z61BcYbu+AszTzJXhLCyMLUi3DjsHVwop3otBbpJHcujJr6hfykCA
         WwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VGcf5Y3br1ZN5VCsPF1qnkiLgAjNrdQuMuRN5l4Pvao=;
        b=Y+cWxnQbk+H8fdfFhLF6aeY27IsgAF5V+/fcMXlgV0YPhtp8EkjCD2BqmwN5wCbz0Q
         iQfTFShjdvCG+AwqibT68Cz+kiqkuNKMlUY0VkKnAhBm5/jbtYinsT+MjXI5rMmQuscz
         fbKPp7tpwylJUUzIp7Hwa+FtqcHO6qQfELmvrwk4cmMdISBECKuxavpA4iWj/Dneg75j
         TJaEwJxTjeESGXQDqmx9Q8udMamufe2QK2wGKg4vomZ5TtlrR7872gx81mxDHejKz5Oi
         9jvv7XmtCHzf8BiKQFhdfGGDW2ogNFvy6Bhk0YMGpBFFzOsYGBxZVyamkFEaeGLyjmu0
         u8WQ==
X-Gm-Message-State: ANhLgQ3tY6D4sFIwhLu9whs8jsIAOiPVeTbuThyMqY7g38NdEJ6rl7Gl
        /DIJMOjHigKbF5yYV3zqZVs=
X-Google-Smtp-Source: ADFU+vuV/u/6R7hgkEgfNn1VytAziH03E4V1sQiurVNeuIkDHwm2gNEwT2lrhwXEhGVXL8EqQ+vaag==
X-Received: by 2002:adf:ef51:: with SMTP id c17mr14779556wrp.130.1585574159436;
        Mon, 30 Mar 2020 06:15:59 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id r9sm21735228wma.47.2020.03.30.06.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 06:15:58 -0700 (PDT)
Date:   Mon, 30 Mar 2020 15:15:57 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] pwm: pca9685: remove ALL_LED PWM channel
Message-ID: <20200330131557.GD2431644@ulmo>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226135229.24929-2-matthias.schiffer@ew.tq-group.com>
 <20200330130757.GC2431644@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6Nae48J/T25AfBN4"
Content-Disposition: inline
In-Reply-To: <20200330130757.GC2431644@ulmo>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--6Nae48J/T25AfBN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2020 at 03:07:57PM +0200, Thierry Reding wrote:
> On Wed, Feb 26, 2020 at 02:52:27PM +0100, Matthias Schiffer wrote:
> > The interaction of the ALL_LED PWM channel with the other channels was
> > not well-defined. As the ALL_LED feature does not seem very useful and
> > it was making the code significantly more complex, simply remove it.
> >=20
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> >  drivers/pwm/pwm-pca9685.c | 115 ++++++--------------------------------
> >  1 file changed, 17 insertions(+), 98 deletions(-)
>=20
> Applied, thanks.

By the way, shouldn't we add something like this:

--- >8 ---
diff --git a/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt b/Do=
cumentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
index f21b55c95738..49fff008af09 100644
--- a/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
@@ -5,8 +5,6 @@ Required properties:
   - compatible: "nxp,pca9685-pwm"
   - #pwm-cells: Should be 2. See pwm.yaml in this directory for a descript=
ion of
     the cells format.
-    The index 16 is the ALLCALL channel, that sets all PWM channels at the=
 same
-    time.

 Optional properties:
   - invert (bool): boolean to enable inverted logic
--- >8 ---

To make sure we reflect this in the device tree bindings? It doesn't
seem like anyone uses that channel (in fact, it doesn't seem like any
device trees actually exist in-tree that use one of these chips), so it
should be fine to drop that.

Thierry

--6Nae48J/T25AfBN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6B8Q0ACgkQ3SOs138+
s6Ea9g//RVwRAmIFdSd4kUfxq4mGgzkkP/iR374s8cs3YnXan9xX+Ft2PAvTEgt2
liI+GQ+TSDIqPcq8wmKr/AZZE8SGoCMTwIdPRMiSoiHchQStGJKcqojBekvYA3+q
VfughzQqqWT1xCgYVdRax8ZJXEhX66DHnHbIc+T8FZy8AA1zwYh7HHcrTJYvmHeC
BbC2UyayeTP6IydIjwLt5M0bWmtDGMz4l80wXkcx4EQLdtkMPBcZ3aIXLFxys+5n
Tr9uDiPx1o1WqWwgasK1nHRRnCYxyh9NHB3Q3q62HoGiSSkgCK8lB+Isttkex++R
dmW8zD/yqEEcaecxaCMh/TxVTYM448ylldMSrlEt6mUY9ApE/OoFI3STqhNzRFCz
0R5y5oNqyYAF0Wln9yMVCbiD9gFuBiSa7jhngWsF+UiWSWH0XjhIhKJCkXDec+WO
yUCqFcczz7ybt4WHU0pckdHO12vxApdE8qjRxkLj3kwTTziUpUtu8to6ll+cyh9Z
//hoh4+NGn8cvZDt1uakZb1zd5++AuG/btQ85EF52wG1JZI1SK9J5Mh/ftj4tIPS
6jLknxNzLhDN1oowvzBVBDTGlTl2CHjKWvQ1de4LEiqLwc6RTrdSb+OwlLhpRxen
449o5YfUaY9mAjjL5URkhuFzD0+/yD0uPTYXkTqfjULR/0N42Mc=
=weCG
-----END PGP SIGNATURE-----

--6Nae48J/T25AfBN4--
