Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82E02D88D8
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 08:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388014AbfJPG7x (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Oct 2019 02:59:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47001 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387777AbfJPG7x (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 02:59:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id o18so26566140wrv.13;
        Tue, 15 Oct 2019 23:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=diX73upTDH+Le9kcw7/XCVjA0EDthPi0kI1j7qCDE7U=;
        b=D45DQTXRZHpHqmNV1ZHx/1jV+zI72KyaocnL5qI5Bhvrm4gLEuEFtVXPXUYWHUfG35
         fLqAhBs2BjHNKQ05KN9EFlH1euiZStEoZRRO7IMq2A9pM2HV115cXo36Eb4MAh9aOKTu
         rbYX09lp4sO4fuO/YdzCEurFqJQduJanR1vYdAVt4095ahIb3hjimbmyLZJyo/QPn0V5
         PQ1E02E0nlbssAYBvHNoZHIu2+ahFhCHowIj/ClyCk2I2DI5+URuXjr7+bHBt1Jl7BN5
         Y1Yex9kIG9e0r9el3lhHv5C9AJ8x9RIGOQARUt1X7CSZGRdtqFTvMuBsWMSVKiHMjZhy
         VnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=diX73upTDH+Le9kcw7/XCVjA0EDthPi0kI1j7qCDE7U=;
        b=sebAGfZkICGwEQOY4/BVZnAM2x144+Hc7F661/9JM536h39VTvRuGon9hQHqCscden
         P/jDLoEtYN7bH7xO5u5ANeBF/UOWzWTWx1GkEzFi1NMFL4M7cjMupTZa1i6YaUr/9n5u
         MWvYVacea97VBaz+cH1+ZPxB6ZTcnKJFDE9/22uUYBFnyvmGJg5NiI3S9rj7f5xCt6Ry
         L5RLXiTNaiF92VJyDRANZ9gg/vTJCuMcH1K+SHh0lW++zCOuD4r0HEWevQiBs7hiR9iX
         NV624b97Umn6rw+AI9mrcVlVGlpuP/3e5ogMNxtluuNa/pvVBNKdXI+NQNi9NCocjAJY
         xqbA==
X-Gm-Message-State: APjAAAX2q0t+w1Vi6uRHWqk9GT6VhYOlSr3X93FfwW4D6MCxZjBI9UpO
        GqCh5/bbpYrYPFp4y1Ia52I=
X-Google-Smtp-Source: APXvYqzw7i7UVTV7xJwRgPRf9mHmCqNLbvW5Tm4FhWaG2fTixmFPnl/QWZqe/Xpc2GrgzM2xBXPoUg==
X-Received: by 2002:adf:fa87:: with SMTP id h7mr1308017wrr.304.1571209189718;
        Tue, 15 Oct 2019 23:59:49 -0700 (PDT)
Received: from localhost ([46.91.226.206])
        by smtp.gmail.com with ESMTPSA id k24sm6060907wmi.1.2019.10.15.23.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 23:59:47 -0700 (PDT)
Date:   Wed, 16 Oct 2019 08:59:45 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     robh+dt@kernel.org, u.kleine-koenig@pengutronix.de,
        alexandre.torgue@st.com, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, benjamin.gaignard@st.com,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 1/3] dt-bindings: pwm-stm32: document pinctrl sleep
 state
Message-ID: <20191016065945.GA1296874@ulmo>
References: <1570193633-6600-1-git-send-email-fabrice.gasnier@st.com>
 <1570193633-6600-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <1570193633-6600-2-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2019 at 02:53:51PM +0200, Fabrice Gasnier wrote:
> Add documentation for pinctrl sleep state that can be used by
> STM32 timers PWM.
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-stm32.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied, thanks.

Thierry

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2mv98ACgkQ3SOs138+
s6HF3BAAmYT8qlTIl02DuYkZiIEEQt9hsB26Q0G5lb9hNoOoKx6lZQ+fH6rl2YGG
4qNTgV7tO6d2L3ip18Khcwjix/qAMIquiQS7X98cRjYA72kq3zwY5hj6pRxwF0Z5
qdY0aTeeN2YpT9rhOR0vjmMfVGDgds9wfCLZXvkYGJ1eIHlrWD7MTDBcQeResxLk
IGpnF6avlEnIlnaVKhUExslBOfivCtPho2GT8mXRQwR2UEjT2hQwJf+Sx98retQ9
C9rrKMP900bMgeyBzQ0AZbZk1/U6wW1yeJaIITR0wJFLN+Gg+FMS+lb/fhGYMKwu
9uQUNAYK03J0FUEZp8Esp1W36ua2XVlmEd+7meqo1OQXBG3uVPpIwTJrBmbPON7s
Q5wHH96B8zjwGdwaVXi/opEDrRezm5c3Ek2bE5cuKfE1grspT0TIqrxmfKnJjzEY
p12kGLnyp7UCaRV8EpUlVDo74koFoMtsCJMNB+PkeZfJEcpoAE1P+gJtt7mWzrXa
dH/ZR6ezffrGbHvH9xKqWLoYSBv1r6PbAiNTJLFCzfWUGBujwQut3bTMNJQoEC4Y
cYPLZnLDnw4Sv7tRoF3nlz3zI5RmQy6qQ0ycz/0CXNv1+W5LVgBa1izwHJ5g1Civ
+vcMdBtQEl6PC4APpHq3jfKFRnO/LOfYRuh8YFl0IwUa9dURl2Q=
=xIm6
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
