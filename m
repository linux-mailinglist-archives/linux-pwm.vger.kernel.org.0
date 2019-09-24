Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB59BC5E3
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Sep 2019 12:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391397AbfIXKxE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Sep 2019 06:53:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51138 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387644AbfIXKxE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Sep 2019 06:53:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id 5so1702639wmg.0;
        Tue, 24 Sep 2019 03:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zTAIzBlG72evi2cgoET66WS7OLBiEq9wKfjo4akk6iY=;
        b=FZ+Hh60KUFlgTLWM/xD3fFBsnzHbq9FsaV4vHvWIIQHTkJ+goAjqbWkTl0lD5q9lVu
         TQ/y/HbMpPwwN6A9pkuEWagjZlURawBTa8Xbfcpn6YllYwnrDtupck0W8U9WIVFN0hzo
         es9q/76FyXW1dxquq/tjOS+BM3y317aYFSyNDq5jqZmngaTwQ6LFIoPsQFwxg1PNbWDF
         ZQKn7sBXgX/7Cmu+SUyAvmTcH9odT4QJI3hXaZsODv/KN7c1TQZDMrPCE44goFQ/7rFy
         kVx7kCmjR82j2y7Vhyo1c4AWTkUzybDBcTz4w4yxgnTIwoSPKZpLkzF/V51pjtx71khF
         iNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zTAIzBlG72evi2cgoET66WS7OLBiEq9wKfjo4akk6iY=;
        b=a9F4z0MeUJXcVW+BS4iMbeQqZIrl6UaQpmezcxaipiFWdmsz9irC5dw7pyle/Zn6VR
         QPVafAoRolk5PnG92LRSDbzpICd1mkkuB3YakmLXFpmbtKC8E8E9pM11VlB2jwU7OsMN
         lo94wjSbRdl8myVHHf6HV2K5RXO9IU2TM+zGMTutJVDiHxgHKQ8y/26WszGaWBoqoPO5
         xRIa+xoUiAIhKUKObceplP4BLClaWMd1JlfmavlS4IMudEJQ4x6h0EaoS7cAiCHhQ56s
         jI9wdK1hi9Ah4nhAklWdmoIAr+16FHtGCoCWp8cD9sxASw9Pwmyjp1LYyY/+kKFNjg0P
         QKsA==
X-Gm-Message-State: APjAAAXQvtZKyDaH9iRMobNlc6gyL/evBnGsK4yhCHzwvHLPZw6BQwOh
        EF/Mtrai1toarE9JgHZeHak=
X-Google-Smtp-Source: APXvYqz/aiWV9T4oK3iswRY/DHmoWOBJTxWMue/zFVZQVujkEp2H3ifBhWSGVYBmpuJ9dVjH15/ZKg==
X-Received: by 2002:a1c:2144:: with SMTP id h65mr2310421wmh.114.1569322382016;
        Tue, 24 Sep 2019 03:53:02 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id y186sm3817474wmd.26.2019.09.24.03.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 03:53:00 -0700 (PDT)
Date:   Tue, 24 Sep 2019 12:52:59 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] pwm: pwm-imx-tpm: Use 'dev' instead of dereferencing it
 repeatedly
Message-ID: <20190924105259.GD14924@ulmo>
References: <1569315667-1525-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pQhZXvAqiZgbeUkD"
Content-Disposition: inline
In-Reply-To: <1569315667-1525-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2019 at 05:01:07PM +0800, Anson Huang wrote:
> Add helper variable dev =3D &pdev->dev to simply the code.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/pwm/pwm-imx-tpm.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Again, positive diffstat and doesn't gain enough for it to be worth the
churn, in my opinion.

Thierry

--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2J9YsACgkQ3SOs138+
s6H7EA//c+M1K7oG4eadkixheMYBpEIjyymh8PkLi2meN3+11V9d0zFBvVRjuoUQ
WyoSvQevjdLRO7oiD00k3Eq4oq12pW1nDKkYie2q/KhK/BkHxO9nZppcGmjxp2l5
vf8g076NvJ3Fuwg8e7aWiNPGDHuy+fSrF2wzX174wMZ6z08s3iCFfkfF68PqxYAx
uO6/QC0Ici6CvltPqVrIMYLtn89BbQYVm5GivwAbzkfoukfcvEyMnPRtsMMLPwys
vuHSVpAy6BaQ0q30fqjErVEMDv/nBmBnK+Wk0S4mkt+31rBARoqhoAxPqU2RTsFT
xekt/OoywxVDS4VsFulovvTSC4MRzFFN39z0IiWQq4nlfpVZqYTPm5+Gh0vIRhtl
Yk6ASiRKbLVBfHTMVKoM2ojwHzLoRu7k6P78POdHdiVVdO2LCCdQQZIfW9mOApO3
fEwqdKaRSfQY/MCv+nyoNYB+Slx+2h6qKon6uracPgaYKPasZILcgWQAummpP2OL
yRox2Bk1NDjkXk0Rb/OcQkG5OwoPh/FIbfsoZHwUl2GxO3tJKZcOnCDTcu9B7aEf
txM17yl9fcS166Ir1yhdna/l1mrC+/Rysc7jfYpUC5D26V1K1zwODYlELFGqGY6Q
21LKYO/js44tPqj0CuJz8DHnGS4RLcn7mQr7b1MXN01ue01DwGk=
=AXDg
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--
