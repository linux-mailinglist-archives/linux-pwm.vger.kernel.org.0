Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87FD29D54B
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Oct 2020 23:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgJ1V74 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Oct 2020 17:59:56 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:40271 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbgJ1V73 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Oct 2020 17:59:29 -0400
Received: by mail-ej1-f67.google.com with SMTP id z5so1045181ejw.7;
        Wed, 28 Oct 2020 14:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IhJDr1KOFYKtq0dERU6JvhmpI21rDzVWNPeoxCOyP1g=;
        b=tbGhUeim0JqJGZdMQyQxaDT9aWFfFODTsQFSdLkD8gzHmJdjC2LhrlzrKlOXZjAE7X
         BGmNbLT2TsNwxadubr2OBZohm4EcTIddTGHgA/oxN4dx9TrGKeCXT/nbTOr2FDmyKvBh
         rgpY3j+DZ5roYXfvpKr3J6j4KOXyjxPVde+xYnnLZAoanE7Dxg182BDFJc/4mnmmS8CS
         GxfFOAHwwvAX6OkpJUsD3Y/A+2zJM4t4PqOU+/USkqDeyvJheuJ/EyZHCCDEBCARzBW0
         FjLJBB/Z99FXcYApJ+zo8xnaqvB4pO6isN7teVJibHq6GpVDk06hBfebrgCY/77NjwYB
         H20g==
X-Gm-Message-State: AOAM533hGxwvguYn6sSe8kI/+GW0XF+Cy3nmvVM2bfVMtdlj+sgWOKVa
        vexsGbWNiZeVb2A0R8YYUzo=
X-Google-Smtp-Source: ABdhPJyaAY5hirP9AM9iwHk+7oGAO7czy2aUScLhsDaWHV8yGg0GD331nuyrXAgJnTfpCQ1We0SMKQ==
X-Received: by 2002:a17:906:2ad3:: with SMTP id m19mr1116263eje.81.1603922367860;
        Wed, 28 Oct 2020 14:59:27 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id c3sm464228edl.60.2020.10.28.14.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 14:59:26 -0700 (PDT)
Date:   Wed, 28 Oct 2020 22:59:24 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 4/4] CREDITS: remove trailing white spaces
Message-ID: <20201028215924.GD269525@kozik-lap>
References: <20201016151528.7553-1-krzk@kernel.org>
 <20201016151528.7553-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201016151528.7553-4-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Oct 16, 2020 at 05:15:28PM +0200, Krzysztof Kozlowski wrote:
> Remove trailing white spaces.  No functional/substantive change.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  CREDITS | 52 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)

Applied.

Best regards,
Krzysztof

