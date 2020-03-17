Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9736188C5D
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 18:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgCQRnt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 13:43:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54431 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgCQRns (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Mar 2020 13:43:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id n8so214616wmc.4;
        Tue, 17 Mar 2020 10:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/isKkk3O5jXZ9+kUxg3p2hySrqn/Bwb/DdfR4A2Wb90=;
        b=ZKy8274IfldCksD2FfPDScwFpZqJL9Uhnw8J2EyjYc7jRDW3iOnoxUXfcKJdExzlgq
         h8ninzBt8aBXx3GRNWNxv8Vo8mpthJ6avVQwps9WFepgi6REPgGewbmLSC6UeDvTt3K7
         3T5H1wGZfNxZ8chAWKFEZLD+F3c5V0npkLRzUCaUEA+hT+xhqP5QFuHq1Y5qmxRhDQbY
         1+0qg+16stwmUlTw3SHmrezF7SFj3KJ9qgijzGkwEhYhZTXyU0w1ZRaf8/Of4Mr83ErG
         SlWiw+G2PXmTv138MGK2ZakhlvPgigEVd3xA7AXWfIbDXtWjVVO0C8GUkHBXj4b9UZP4
         srbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/isKkk3O5jXZ9+kUxg3p2hySrqn/Bwb/DdfR4A2Wb90=;
        b=nwn3Z1NaCq9TfJjNwAfjzfoKRNuwCGzCy0HxfyJUvzqFzoaxyA3y40VC5hqRFfptS0
         TFm3ku2IfqacVvYvBIUmwiGfEMb03HqgS+UPs+4QI18kv8NKdtvs+Ri+XbCIWh0UWAEA
         o2Z3EfY/8yYxAj1R4REuzICcR4NRUIvlPRYdooAtFT5OQVUXqFhLjLb5J26mtpRMKd4t
         Hs4kAtm5Sx7ySrlTjxX1FrxiPMr4TfX31ZYCvYo8Rlrp81TFHLU41ivADbuuwDp8DmQM
         AfHrPOPBySPpdIi1MKVUMIVNZE8pmiokMQJFKsD4rNvHJRG3TBrA37pKHt+UddlxaVAT
         +Hmw==
X-Gm-Message-State: ANhLgQ3iardYz5mnRbM/ewNsKkFHawD/nDq2vDBU8HeuUCOCxD//k35c
        CCz+VVrrwZemTGYe+FsMf6g=
X-Google-Smtp-Source: ADFU+vtWMTV3NJW9DuUit/s4CW52s8HaNylmRzpnQxlGQzAzqr8zjGwViTgYsDSfx6SV+HKl1Lq4Fg==
X-Received: by 2002:a05:600c:2f01:: with SMTP id r1mr146089wmn.31.1584467026503;
        Tue, 17 Mar 2020 10:43:46 -0700 (PDT)
Received: from localhost (pD9E516A9.dip0.t-ipconnect.de. [217.229.22.169])
        by smtp.gmail.com with ESMTPSA id l5sm5424360wro.15.2020.03.17.10.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 10:43:45 -0700 (PDT)
Date:   Tue, 17 Mar 2020 18:43:44 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Paul Barker <pbarker@konsulko.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/7] dt-bindings: pwm: document the PWM polarity flag
Message-ID: <20200317174344.GB1464607@ulmo>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-3-oleksandr.suvorov@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <20200317123231.2843297-3-oleksandr.suvorov@toradex.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2020 at 02:32:26PM +0200, Oleksandr Suvorov wrote:
> Add the description of PWM_POLARITY_NORMAL flag.
>=20
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> ---
>=20
>  Documentation/devicetree/bindings/pwm/pwm.txt | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentatio=
n/devicetree/bindings/pwm/pwm.txt
> index 084886bd721e..440c6b9a6a4e 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
> @@ -46,6 +46,7 @@ period in nanoseconds.
>  Optionally, the pwm-specifier can encode a number of flags (defined in
>  <dt-bindings/pwm/pwm.h>) in a third cell:
>  - PWM_POLARITY_INVERTED: invert the PWM signal polarity
> +- PWM_POLARITY_NORMAL: don't invert the PWM signal polarity

This doesn't make sense. PWM_POLARITY_NORMAL is not part of the DT ABI.
The third cell of the specifier is a bitmask of flags.

PWM_POLARITY_NORMAL is an enumeration value that evaluates to 0, so it
makes absolutely no sense as a flag. PWM signals are considered to be
"normal" by default, so no flag is necessary to specify that.

Thierry

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5xDFAACgkQ3SOs138+
s6Hc2BAAoZZlHyfYsr0Ak2f2q9OT3sqed38ZxCtTlrr7nV0EMRX9lArVOG/WYqZU
j6UFpsHK5VeEVd7g0+AmwlGNMuCSkh8Fago7cFqKwIWgrYlk0P4MAOdrt1CLf5ky
KO2B+YLCLiV3Jc9TYFridWcCAR1XCU9xkvVVBs2DM6j7FqSG3zLXe1OklBM1mnTL
ha6UdP8Nr46AodyfFh9H+1xEzNf+BGnycoN+c3k0AfI2QEvntJywgb+v+V6ELIUd
nf22MsydZCIRYbrl74154RESKQ8wPtDtz/XaXAiGxJAd76K5+PBFNIEY8TJHXdQm
uEQVC7g3OUNANYaTdDLtn8EmmK41UqZOK9T8Hc9zr14zh1asoPkALoPQv/6aY7At
19uamsnrxupfTmneh7K064G7InxbeecxPo9H20aS2QVYNegA5ZvCYLjcjASOfesj
AGxze1cMvK38uD0Ujq8n7hLerMBGZ4IBH4S9Kt68iCbClF5XwWZQy5yhVywqtEs+
1D2HpCWtcImoEnBywcAiA8eE8Bp6ByZkz0PscumS03TOiy1xI/IRbqCaUMnNkYC2
cKnkghSEsn+Ilg9rzXNS9gvNVj4v3e+2GBFaF7rHUBs8+TOzn1dcB5iubq+55RLW
Y8uyGklJGKA8NyVXF+0u4At8XhYGzCR1296yga0NPv3GzHEyqlo=
=+U+H
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
