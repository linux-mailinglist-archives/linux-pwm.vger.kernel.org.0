Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A86071A2FC1
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Apr 2020 09:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgDIHJf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Apr 2020 03:09:35 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33694 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgDIHJf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Apr 2020 03:09:35 -0400
Received: by mail-lf1-f65.google.com with SMTP id h6so7152509lfc.0
        for <linux-pwm@vger.kernel.org>; Thu, 09 Apr 2020 00:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=dw2g+Rcie247VAtOj8hXWu0+p4yENHERtLxJGVmYzHc=;
        b=QnpyEdEjTn93ZF/GV44ThpydZMyNvoo15dEBCanYGKiGXdKvQ8v+pihThorf9Ur2pG
         cXG5VZPt/muMi5rRCPPnqhlIf72Q47k2g+yxUoVYKKaUrS+gjYFtYvMFE7onoSNP0haV
         s/ypQHa3U28gShWcbkVEizNdOC5RvApC/u3TK82ySvulJJmsJ0xCsyqJm4Jwxx0P91MS
         XDmUUbDrIYqCnDKwpfhHNJE8FbSHhizf4d7MkAPuvUKJvm8azAVe+M1nxwzvM1Xpcpl9
         W1rMxGau68eXAk1qmyT8tNvcCOkkZebhT4unqUPUHo+6+9K9EeCYBWk5l8qt+0zFbJgX
         WiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=dw2g+Rcie247VAtOj8hXWu0+p4yENHERtLxJGVmYzHc=;
        b=hkp46U+nj/fbBkuRb/oWD/2Xhcp8TerSZrQFPQlMmBTEoXDD2BCMNsEZuwhOc91Byr
         u0mbfaaJsZyyofqscs7lVUL4KnXYFqgPFmdzx/sW3Nt5XhuqdLPyJceClV0tbPwrk2Pk
         8LGyI9CMQGCj2DjPV8jKd1COY2KbyZdWEMwROw/LgyLqgKRxpFZ8Ur2i2ge98DxQl36I
         w6Cffk6113X8rS4c4s57elGcJiZF5n0RhET8xzyQyY9jqgI8OuB5pvimN0wZrh8xwSSD
         8ByhsrmXlFmwVv5Ikv4rmhlAQ+DeWgrZLO1lyGMbh7sdK6RAkeUngPAD5B+Fmh6T1iEk
         SEew==
X-Gm-Message-State: AGi0PubsCgg9Ebn37y+4XN3FULgyBCIq13bHfgsnu6kSZpl9G3ByXTPv
        kihexSaW0EMNC5gY6rLUkus=
X-Google-Smtp-Source: APiQypLMm+D76CWTy/qzlS0V1t0QQ6g+Zwek/qDUzM8QrNYQZM3hTME+dnlnSl6eKjAnBxO0jmKhMg==
X-Received: by 2002:a19:7411:: with SMTP id v17mr6978885lfe.27.1586416173186;
        Thu, 09 Apr 2020 00:09:33 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id g13sm653526ljn.82.2020.04.09.00.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Apr 2020 00:09:32 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K?= =?utf-8?Q?=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Raymond Tan <raymond.tan@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] pwm: Add DesignWare PWM Controller Driver
In-Reply-To: <20200408125404.527090-1-jarkko.nikula@linux.intel.com>
References: <20200408125404.527090-1-jarkko.nikula@linux.intel.com>
Date:   Thu, 09 Apr 2020 10:09:27 +0300
Message-ID: <87k12pgmoo.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi Jarkko,

Jarkko Nikula <jarkko.nikula@linux.intel.com> writes:

> Introduce driver for Synopsys DesignWare PWM Controller used on Intel
> Elkhart Lake.
>
> Initial implementation is done by Felipe Balbi while he was working at
> Intel with later changes from Raymond Tan and me.
>
> Co-developed-by: Raymond Tan <raymond.tan@intel.com>
> Signed-off-by: Raymond Tan <raymond.tan@intel.com>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Thanks for sending this. FWIW:

Signed-off-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl6OyicACgkQzL64meEa
mQbpjg//evPIzO34GFt9Fosbe23C3xoa6XP4xIwIKOAeoDnTJsgEA5fDjjlysbP0
g85gtb2CklkiEIbXtbT5cDIkCwGE6otxg9fudUMfjEfDxRRuYn94YdycYe5fMPkk
t0I45tehq7McnJTtDV7XfuOrzXlKonphLoobxoopbQ/DwZi461g5Gu4rRLOpwzJG
AKesWhXSzZ6NzXpQwVBH7Tf+dDpCv0HFkB0E+R2bsQdrDPbE5Qk+ClPSCOcK/cnp
qFfv1cgo7GVW0rrN6kg0VehUmBEN8d5Hd/NZ/O+WYx9JzApkab+oicaIxYSxN4Ij
yp4juc/xsiixktj5qLzqLtSmlfGdjnQ4S0E0exPZvSGL0DavmhHLwZiD2/kO/1kB
Me7GMPpo1rRAYcCRiHsULJIY7lv5bdJqRe6v7UhWK4aTK3aOZH/bZjbsDzHe4nfk
tii30QnNOG+K9jz61XcegE4wnm1v0qVw65cBiovn8ciUJOS8dkK2FQyDqpYgiDrD
QPYlPrLG8AcrxveOF21CNOye3s/fle61lywe9OMzdGiTmrE1uMpKvocHbsI8y9Yb
P4PXmtdrHjqeqdlfijZnf/PNVsGpE7Vqkg0hHkxUycxpkM+wcUfBLBK8nNQD0hWE
6FGkyx07/EUgSSjplegkWCITdtpfmDBvtahoaZf0nRXgL1dyZE8=
=CKGr
-----END PGP SIGNATURE-----
--=-=-=--
