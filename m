Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC07B17EB83
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Mar 2020 22:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgCIVs1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Mar 2020 17:48:27 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36819 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgCIVs0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Mar 2020 17:48:26 -0400
Received: by mail-pj1-f67.google.com with SMTP id l41so503224pjb.1;
        Mon, 09 Mar 2020 14:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M+Yc5KaBBvqlUu6IX9+jhdSvvYBrtTQ1N/+uZrTujAY=;
        b=EnAOLY3lknQn3MrFOnTG47rE/msuLtkHcwI9CiqqLxAphICFFDtZpSmVBdHY1gjaT1
         nF3ZgHtiuEflpauwpjHLTa11NmOBCgIGoRnB/lC61GeUFJGTQUhR7M5jhLKEkVom/atE
         rGNK46z/+EJGKYmexGaRptMczx6WalQZ7vm1+hnINGCorC4R+/lDj28HCN2YFObBXibf
         TbBc8ktb/3tvgKvbKZYVuXQFQ1jCh7q5i2kNRpO8mDbWAxKJ4bf2OPG8x6COaosxKY5L
         JbUlwomEzIjo5YEQYdlVnYLt8bnVg32QPMRPbi/wBzdkVbfsh8Q61ZV2waG0vTF+9vHY
         Rdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=M+Yc5KaBBvqlUu6IX9+jhdSvvYBrtTQ1N/+uZrTujAY=;
        b=mm7w3L8jqlQIB8Lu2kEgJxyj37wTFyz2EXsB840lnf6J2Wfio0xEfHjW201sfChTZr
         bjFAuPv5mC1gn1ux0eEJKc0qQimcpXBxZZ5ivDC7wgnc6sVqBYGIuduMOeqhG8qlErOy
         RjP926mWRMhXUVFWVOOOJdGskqAVJ8PTOYrDmeKZWjCNEKkrdPHQ0KFZi27D7l2XyA3K
         os0kSgnol6L/ha9RlAtqDD6+rcQlfjiOhZ42NVMvx19h+vXdU+MAPE3YOeNlOyvWwRop
         ntPccf2Q92sAXrCFu0XijIeg/64JgHKrB+k0pXPAwfy3q5WGocl8lKxZ8Q3fi1tSCFcr
         h6fA==
X-Gm-Message-State: ANhLgQ0bbrk3KOLcIuUyShwCSv7CT+iQh+iyEZ/GhN8VctyhYwSkfVDH
        3V9O0t6TCjsx6N/jj/XCZOo=
X-Google-Smtp-Source: ADFU+vspwoKFKjFMDUf9nlAvLvUHioLAIIAwk15+/ODm/1HJWpwGZy4//EuoLeQ1SRiulbB+FAF01Q==
X-Received: by 2002:a17:90a:ba89:: with SMTP id t9mr1352540pjr.93.1583790503831;
        Mon, 09 Mar 2020 14:48:23 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q15sm9321748pgn.68.2020.03.09.14.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Mar 2020 14:48:23 -0700 (PDT)
Date:   Mon, 9 Mar 2020 14:48:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org, Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v7 03/13] hwmon: pwm-fan: Use 64-bit division macros for
 period and duty cycle
Message-ID: <20200309214822.GA19773@roeck-us.net>
References: <cover.1583782035.git.gurus@codeaurora.org>
 <b503833e0f58bd6dd9fe84d866124e7c457e099e.1583782035.git.gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b503833e0f58bd6dd9fe84d866124e7c457e099e.1583782035.git.gurus@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Mar 09, 2020 at 12:35:06PM -0700, Guru Das Srinagesh wrote:
> Because period and duty cycle are defined in the PWM framework structs
> as ints with units of nanoseconds, the maximum time duration that can be
> set is limited to ~2.147 seconds. Redefining them as u64 values will
> enable larger time durations to be set.
> 
> As a first step, prepare drivers to handle the switch to u64 period and
> duty_cycle by replacing division operations involving pwm period and duty cycle
> with their 64-bit equivalents as appropriate. The actual switch to u64 period
> and duty_cycle follows as a separate patch.
> 
> Where the dividend is 64-bit but the divisor is 32-bit, use *_ULL
> macros:
> - DIV_ROUND_UP_ULL
> - DIV_ROUND_CLOSEST_ULL
> - div_u64
> 
> Where the divisor is 64-bit (dividend may be 32-bit or 64-bit), use
> DIV64_* macros:
> - DIV64_U64_ROUND_CLOSEST
> - div64_u64
> 
There is no explanation why this is necessary. What is the use case ?
It is hard to imagine a real-world use case with a duty cycle of more
than 2 seconds.

Guenter
