Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 938E2D8D9D
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 12:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388413AbfJPKPo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Oct 2019 06:15:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37471 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfJPKPo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 06:15:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id p14so27335868wro.4;
        Wed, 16 Oct 2019 03:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xTYmNxIvoNbSeEdEWMDABklCOiul8eFwZIjECLgcPFY=;
        b=Hi40LFlKax9B+XeWvVP0/JnhaYHwRhvlr6YXTC4eJn9m+4z17IVUEWl0G6GorzUZLg
         O+XE5nKB+qqNsDp8msmr4jzzRRFIDs5LwAy3ksTxShmLNsN/qd9G4Kf/mQmfg1D8XdS2
         vj8YGcUod1VrxOf6Fcpf8JIn18vHEp2xWliH9bVJehseKPJ37MbaPcHy7gLkrOKNY9WW
         cO6imrQVkhyDUcysLMPNi3pyZiE0KsyY1aodZEAYfytTpwnJa2KfkJfY14rJQx2gQIwV
         D4gcE49yUa47ZahBHiG4t7Uqc9UZJMnIyu5/fUvUiwIW2tqxE+4hyRa/3RIWOhlbIT8N
         aRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xTYmNxIvoNbSeEdEWMDABklCOiul8eFwZIjECLgcPFY=;
        b=Tgegb25e+3HjUbokl2lm5tvvlI26OBWvbSB+H7p2K/K7Myn71UH3970UKYxO0BvLmk
         AhFeYFQTVdgsWXoAduz035oTHwi4q2HjBqBJJwaKH8U5K4/HnNqd84fxrx0pF9rCOcwq
         K/1X9RfRkEo6w8X9a4oYTXkQuYxwXszQYufv5ngKbIZIUj2mXH/WFIAKVBpSVaGJokZT
         BcHiDsktBkDXaH9GF/5wha+NPwNHE9rE865k6GrYw6IAbGBVw5bYv0XRcgKC+pz0oA0r
         tg3nUJ6HiyUx5jS6QAHa/+9uqF0+bW7mRZ2hgvFWxuYckURWugZtd8pKn6S1hYdqL9HU
         XxZw==
X-Gm-Message-State: APjAAAXmUIRpQTifxOQxe5pqIIp5wJjzL/omOhdTKrw+sMXJLVTI289u
        ZMb5VWB7ihnicRLNhZcZqaXBX5VK
X-Google-Smtp-Source: APXvYqznNwd3RlN6p9r/yjEk3JyywItZZxhIWwoJ/kLcelEjNkg8PVYZ5TH1+yBKm/h/VURE8dUmdA==
X-Received: by 2002:adf:e8c6:: with SMTP id k6mr2000102wrn.78.1571220942038;
        Wed, 16 Oct 2019 03:15:42 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id r18sm2282447wme.48.2019.10.16.03.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 03:15:40 -0700 (PDT)
Date:   Wed, 16 Oct 2019 12:15:39 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org, kernel-team@android.com,
        Mark Salyzyn <salyzyn@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] pwm: Convert period and duty cycle to u64
Message-ID: <20191016101539.GC1303817@ulmo>
References: <1571191899-6150-1-git-send-email-gurus@codeaurora.org>
 <1571191899-6150-2-git-send-email-gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline
In-Reply-To: <1571191899-6150-2-git-send-email-gurus@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2019 at 07:11:39PM -0700, Guru Das Srinagesh wrote:
> Because period and duty cycle are defined as ints with units of
> nanoseconds, the maximum time duration that can be set is limited to
> ~2.147 seconds. Change their definitions to u64 so that higher durations
> may be set.
>=20
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  drivers/pwm/core.c  |  4 ++--
>  drivers/pwm/sysfs.c | 10 +++++-----
>  include/linux/pwm.h | 16 ++++++++--------
>  3 files changed, 15 insertions(+), 15 deletions(-)

Actually, we can't do that without further preparatory work. The reason
is that consumers use the period and duty_cycle members in computations
of their own, which lead to errors such as this:

	armv7l-unknown-linux-gnueabihf-ld: drivers/video/backlight/pwm_bl.o: in fu=
nction `pwm_backlight_probe':
	pwm_bl.c:(.text+0x3b0): undefined reference to `__aeabi_uldivmod'

So I think we need to audit all consumers carefully and make sure that
they use do_div() where necessary to avoid such errors.

Thierry

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2m7ckACgkQ3SOs138+
s6E3vRAAnNeRoEkw1nWChlsRV2oFUeMV8EhmXTwbwrqtiCWmnOjb+/EOZEnMSemA
hmjdlh2370rL41Gubfgw0xk8Y/ndu60GtgoaW0KMJvcgYrfxtb72ocoJ+LREDHTq
YZOYVUaouvpqTqjRil81m6mSdOh+yuwTvL1Ey+rbiBP4FJ+tomPYqwXfIgr0ckxQ
dQ0BUN6NcAph6j1IadOq3baRStp6Kh74lkLnMbHQ5J8l/EWlfx4sL9jim5E4B/pi
umbV5HUo12yslZ9Rv991p9gk8H87tVgPzjUp6L1xdLQvevuTL5nDPmBjPlYCJPcT
nhLNWQeXJoKT6smGRasNTA1YFIB52Zz0+2RnhzwhSo86xMs0Eo4GmLSFIB7kGY+i
P8OXO68Ak3hcD5hwb0uftnTwleVDhmxhBzT1yvWG1cO9qzGPq54UuJQcJrjEslOm
FrHkmIk7IkqVIQPCWYZTG2qqc1+mlksnJC1zJ5tZjVPdGnFnbUOACXF0WEyI83xO
cUln72zQBf1cm06DNH+50zrUbjRyRK3poQaQ/RLYZvfGVICe2s1q5CzqJnpg5Ggb
/pofEITAj7ehCarLCb0nnyK1pTWl3MLtIStJ3kitDnmEwMo5LahtG3/HN8JZupuL
BIeelKTY8NqjYaOFFW+lw/x1JssudLHasSNVGX0MMb/5Y9oPYrg=
=wQCl
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
