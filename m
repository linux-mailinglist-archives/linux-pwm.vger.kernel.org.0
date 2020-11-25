Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816F92C48C4
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Nov 2020 20:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbgKYTyy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Nov 2020 14:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729811AbgKYTyy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Nov 2020 14:54:54 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B9EC0617A7;
        Wed, 25 Nov 2020 11:54:54 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id u7so1827074vsq.11;
        Wed, 25 Nov 2020 11:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=quQXC001ckf6FPC2C4/1w3Sse9lO9A5NO+66y8j62lo=;
        b=OkCOBbNS9OlJjOgP0sPulOSrllZcljcP6yh0uZxSiJj6PgHM/LRpid+kB02nkJNXJU
         V03kaTDfEpiQHjm2NI8FxqgF04eqnOnbDgBNnf7UJpcIjLfTpggSimyYxx/h9HHsudLE
         SqbetPDSEvwwpxQG9exRooLi6mk9fZeFZ/IDmQoQd+3NYcYxuJhGAayV34tabr6pT83F
         qzpGzC6UWonumhW0+GGgat+WgwvxDfp7dCl8D6DY/XcINF0IQwBUykAtKbPrMe9E80EW
         sPZt6z2ql1FLLN55+pdf4vO88h57gP4Kqb5Pmj/DaL2asZbLZtNqyu7isztoJjVkjHXP
         Fwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=quQXC001ckf6FPC2C4/1w3Sse9lO9A5NO+66y8j62lo=;
        b=IvkX6TrrJx2vUHv1sqanTw4DboK9pvptxjGx+7CKPIvKICIiqtsYQgt+ZoejZwuGgb
         qKsphWDRfvS+ORnxNH/tUYPYGCPxPOXUQpiJ4WyafRYO67ZeJF9DBTTRuH0ISgjMF21K
         8+K2Vb4I3oxY8arpAnT0KldsPyYVwNuQPYA9ymsEIBpOHj3l/xlyFg3FEtBsdmAbJW7I
         lXsilIHV9pTZ4/kPneOcm6dPZwvHIuwIkiD0nBq/KgzFY57lNqJAUlg6ZAjiz9CGN9J2
         T5t9yC/rrAhfvbnOeMIj34e6uN/HA6lr82lZnOq3izsFgTsSB8VZI5dpmrZ+Va0fZSaC
         CfdA==
X-Gm-Message-State: AOAM532ry9SwJVekSsfxKMOuaLSDez2wScKx2exnqWhXQkgnz87ypThy
        gn3VuVTzpC64Ty+LwWRv8f45BZav9y0cPu59gS95ntHH
X-Google-Smtp-Source: ABdhPJx9Qnj66mEDQsfRqNZZHqnMinb7zge2C+8+aNYpUrk/kzU0PbeajTpFQ16HodTZXaQsFjs2N9lBZQmrW/KmL1M=
X-Received: by 2002:a67:3115:: with SMTP id x21mr3572812vsx.12.1606334093402;
 Wed, 25 Nov 2020 11:54:53 -0800 (PST)
MIME-Version: 1.0
References: <20201124181013.162176-1-clemens.gruber@pqgruber.com>
 <CAGngYiX8KOTQCScWo_o1BRa8CGHBQzWZGz1FmzkwGEmyNgPaxQ@mail.gmail.com>
 <X74XPAy+SJRmQUSH@workstation.tuxnet> <X75kXv7l9RbTOS7S@workstation.tuxnet>
 <CAGngYiViOMO6uM7UeYO5fNMdc+QEjLt+L1TdTii+smTvsmV=aQ@mail.gmail.com>
 <X76ULTpaWHLkkz/u@workstation.tuxnet> <CAGngYiWVYy=U0bkK7w321Qc7eu9+bEC7asvJAuX7t+OLfimOAQ@mail.gmail.com>
In-Reply-To: <CAGngYiWVYy=U0bkK7w321Qc7eu9+bEC7asvJAuX7t+OLfimOAQ@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 25 Nov 2020 14:54:42 -0500
Message-ID: <CAGngYiW9MPzvA=KEa8czDrXFhx1BQGdJv+99xJQOVgvySaZfhw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] pwm: pca9685: Switch to atomic API
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Nov 25, 2020 at 2:46 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> Then if you have time && motivation left, enable regmap cache.

In a follow-up patch, after we arrived at a correctly working driver.
