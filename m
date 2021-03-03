Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D3432C577
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Mar 2021 01:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347850AbhCDAVG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 3 Mar 2021 19:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842913AbhCCKW2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 3 Mar 2021 05:22:28 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C07FC0698CB
        for <linux-pwm@vger.kernel.org>; Wed,  3 Mar 2021 01:09:20 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id q23so27669984lji.8
        for <linux-pwm@vger.kernel.org>; Wed, 03 Mar 2021 01:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s/ftGumlRNPAdvb+UWvT2PLvPwoGzMjtbzohIB+RDfg=;
        b=yeNAepQjMUV1WWbbhptXnI1rJ0p+XLhku1dfbt23Y6gwQDaU0uBTmSc7GINWZar85e
         GN1L2sMYJWHQYqoQM6b7qwcOmbpcku72D2ikxcRBa89ZT5Wn+DCtBf8fnBBFWbK/IbUE
         8/wOyqYdodzmwkRTFfcqVl3jvrma7yg5oYd0DLnAT/o+dwJgnso0jVoQIl2rc3BqDcGJ
         zz1rzijWqk+gdIlltztOJg/EMC0tkuunNcKVIGr6xLg0c+zmQF/TwmKA0CV+cOpBRB3T
         Qskie2w7OsT3hxlHWyjAOZAecdn94HKnLGxd1ghuIF/vM7/m5mVaHCb9FoOmzB1Ev00O
         M4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s/ftGumlRNPAdvb+UWvT2PLvPwoGzMjtbzohIB+RDfg=;
        b=iNeTuNrx9gXmT30F7jgV73eklymn83sFty+UGebzcwSGpSlUoxsEM0Fc5oR+cp4VYe
         tLsAPtPOzmJgJXD/LA0S6q4ZZPcmF75zSISf2XfsY9GzIrb0ItoTRFpipRoBKZvqMG5e
         nBfhylJDZ3mhHjWRYmRSWjwsITyWA4peOniYqxrL3Npmvpbsh150qGCuHWTNzPwaIso3
         QrbRLnP3UVvwWI+GH7bJJ6kJrl1J0WrRYGRT7Rh/SOTayoq20CPBobCTJQJoXDYM3hVB
         jFwAl4szy2rZt91W7y7dhv0gbTAkkO/LEz1Y+ZkC926/pd2MwNJA9Qfe2NdZpeAQJyZc
         7f6g==
X-Gm-Message-State: AOAM530yPSbmckW6uX/np5bRbJPI75ce7uPAJx8yJlhUHdDw26bScK1P
        2GDvNV9KoITrIluU6sLEcbPxcvzyTCOm2BLAg1STEw==
X-Google-Smtp-Source: ABdhPJwi6gtOpQ7/5pPNdF8W8BwyeFunSUg18hn9FiWcnPdFNxQ1om+cQBZMU1haqdp03+gBYUG90vLtIwv3MWYRlfY=
X-Received: by 2002:a2e:9cb:: with SMTP id 194mr5441670ljj.438.1614762558695;
 Wed, 03 Mar 2021 01:09:18 -0800 (PST)
MIME-Version: 1.0
References: <20210301184537.1687926-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20210301184537.1687926-1-u.kleine-koenig@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Mar 2021 10:09:08 +0100
Message-ID: <CACRpkdZ0S5z7ex9j0mQxu8pwVA0FPFtDG0LRkC7w2tXQnLs45w@mail.gmail.com>
Subject: Re: [PATCH] pwm: ab8500: Implement .apply instead of .config, .enable
 and .disable
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Mar 1, 2021 at 7:45 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> To eventually get rid of all legacy drivers convert this driver to the
> modern world implementing .apply().
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Looks correct to me, thanks Uwe!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
