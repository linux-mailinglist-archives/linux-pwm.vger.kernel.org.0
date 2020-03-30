Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB71197C6C
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2020 15:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbgC3NHs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Mar 2020 09:07:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37095 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729985AbgC3NHs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 09:07:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so21595870wrm.4;
        Mon, 30 Mar 2020 06:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wO+JXh3pp3he9InJ+e9hy2w03EPb92yFuSHwoMFvxyE=;
        b=bQhLs81QH0ybs0aXt/VJtrYfSgW4GOKOvAr96BV6wEns//RYWBqWndgXY7Rn31xghg
         Olx8j9+vGDz9UqX62GVp5T19Cvzazk+z+HD+fUBKIJTZG0AVBlll4OjqMgzJQyvhV+0W
         NyOJLUY2DKDIBWg3RC6HdJbUpYxQrhCtaHJ7ybaq83SQRE0AB7EhOMlqTSbCLbAkRSyD
         rY0OMzr4/QMr8XVxZZTPMR18Y2UKIXGOjylODokVJNcOVFWabHHh3zoaFYrV+ZR8hVpp
         ls1MTVOG/jhTk4ibpRkb1Z3YvPE1ptQDtdt/ai18INIfQA2I4eMy2jbOYUWrLIsXAxM9
         K7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wO+JXh3pp3he9InJ+e9hy2w03EPb92yFuSHwoMFvxyE=;
        b=eNCTumSuTVs4rXTkNDkSzdbViSKJHQcBxqQULYSu1Kae6mQxgFIO3xAhIfRZLSS8gu
         zfXt38/d4BC2VPxnINfwNWxO1H1/lwZ15d3I1XkOFWZBnMckOHo1fB2PilUlexxJcUt6
         8TkZqI9bkDSQ82oXQjo0zbpWPPvu2LsM71Fvv9mngXCQSBoAuL2U5j8ufp9xLHTBw1wr
         96LTDURYZhajQzPhxg7dnTB8hUKo8JS5+2Iz2rUeKnhJrsbHtzAVH8dzFizpsV34Asqc
         tR045pVZUmNuqdBgG2Up4dwYYQ8ejzqx+JSyIm0z24CiEr1xD8LAfkqHfAr1VbR7IWOd
         ve3A==
X-Gm-Message-State: ANhLgQ3H9w+7ayRqesH9GB+rrqaMGZKxmkxns4Tmv1oRVBjw7MHwPA2R
        0Xek2c/AYQ+qvcVNsZm9FPpzV6br
X-Google-Smtp-Source: ADFU+vvNeIDZ/mGs3wN4y2uDohE39DB+zUjnatH2zIUUOrzl6vD59Jd5Tu2AiqZ8YBp2rR/MA467Lw==
X-Received: by 2002:adf:9dca:: with SMTP id q10mr14506777wre.11.1585573665877;
        Mon, 30 Mar 2020 06:07:45 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id f20sm3264065wmc.35.2020.03.30.06.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 06:07:44 -0700 (PDT)
Date:   Mon, 30 Mar 2020 15:07:43 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle struct element
Message-ID: <20200330130743.GB2431644@ulmo>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
In-Reply-To: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2020 at 02:52:26PM +0100, Matthias Schiffer wrote:
> duty_cycle was only set, never read.
>=20
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  drivers/pwm/pwm-pca9685.c | 4 ----
>  1 file changed, 4 deletions(-)

Applied, thanks.

Thierry

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6B7x8ACgkQ3SOs138+
s6EaLBAAgAn/lgDB44oc59O/xOFW9osN2zFPkz231wt++SqoKpegoQSRAKbqdpeZ
lMD6fk2mxySvY5syYnQ+BQe4J6of70RJ7ID9+5UgFInF7mx25O+6LmtmgmszQkbF
PutCzVtQ5SDjTGO5SBQ3D+Kwkq4pQarcd+d1oJqncl8zOTiJbKkkD0mKgwmm+eQo
2ZSnp6h7nN1gbsaF0K2DuzCtCWmYw5ZfsOvU+i77wszL7KQQwPUL0TBN2DDl0ROV
Xeh9FvZBfyzObO3v4T/zaN7GO88fnqCC6KU1pJb81LjmdHguo7pylXAm8W5GiSln
xFIwWgQ7Yw0Z/niZCo0jmujYelIckGoDyxvUzwmMPOHWzXMyip5RBHmof3HK/cmK
iCXYX2c9Z/3Lio1FzZGzaJqLMk+29qWg5Ck9E96Q8ClRUBV9uy390tGd30fb8k8M
lot06XClM9cbUYnIOeu7pOKAVmimZiiXE4UMPNr39X4uoJgTxt0mmW9iMgafEn8e
jX6+iBXA8c24DTwtuJMo6BaNvsEkkhVw0qXwV7DObRokRxVUG+98xPDRA/+6dwtz
BGeS7gRq38xnPzIN/vEfnp1qU9ZIFVkbj/rXWMskqDTmZnn27fpamKHYaM57Ad7V
Po4ZkDx/K0H1hv6l+DQ0pABBoOLNr2tv5CbPD/wZP4ulgqdOcCY=
=pidG
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
