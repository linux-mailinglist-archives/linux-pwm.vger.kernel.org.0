Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88F5E1885F3
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 14:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgCQNgn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 09:36:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45265 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgCQNgm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Mar 2020 09:36:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id t2so15647825wrx.12
        for <linux-pwm@vger.kernel.org>; Tue, 17 Mar 2020 06:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=C5UUMlB1vuVsFqD+amvxd3LJdmlP7Psxf6b/ICw2yeE=;
        b=se96Gfa2PabhLjXbMk3DF/dsiXpQcRoXaNnO0MF+OIOP+6Ga54A4maQX31UU5r4vPU
         5/hGqPTpnRLR8DecY2Pg23NZ1/yWDIJoZWfsSry8XsID7ZcqDz1R9QAiNgSTrPlRbaqx
         Kx5W9cykjsWagYxQgEhiKtKMvH2zCyN6USHJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=C5UUMlB1vuVsFqD+amvxd3LJdmlP7Psxf6b/ICw2yeE=;
        b=rJNTF3OrCqVoHSt9oqP8OgqRltqCrpYn3t22wmCw4Vrh98P6MPlVFxiNlH57EWQ0U3
         qMQ9Vwoa1+WHHmUbO/tF9i/adMLnhpdAU1J4dKyoHN40PwOA+NqC8HoMieZpDdhr+7yY
         OfaCAz2hCNjlYGWl8GNvLtRD5O8uxr0kEnsU79lJ3EKHoQPoSxXs6otgvsq/WxE0GWUU
         WVeJpFmWot2KoetppwBLfa/ItnspDMoHLNaWVC2bw1LTGDiIqu2w6RjwRQe8dsSZmGNH
         5cfCijGtN/fLBtm7NXOHvcdTR9yyj87QeirdzHd+5lcB+yHb1pGtP/6/vxL4NAoiAMNv
         RVoQ==
X-Gm-Message-State: ANhLgQ2lZrHK9BlSLXXFFaDXZy0YB+DG6qJAoxIgReENI7qOnEeNBcq0
        KY/gxQzNCr7DccU1P9XZnHcfKA==
X-Google-Smtp-Source: ADFU+vt2hjTZMVdUwDmhSalbO2esCViQhgfOwq7UWI9SwWOAqbVu4rfpvcU688VZVd1B1aN3n2pb0g==
X-Received: by 2002:a5d:522c:: with SMTP id i12mr5953325wra.176.1584452200128;
        Tue, 17 Mar 2020 06:36:40 -0700 (PDT)
Received: from ub1910 ([213.48.11.149])
        by smtp.gmail.com with ESMTPSA id k5sm3743373wmj.18.2020.03.17.06.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 06:36:39 -0700 (PDT)
Date:   Tue, 17 Mar 2020 13:36:38 +0000
From:   Paul Barker <pbarker@konsulko.com>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/7] dt-bindings: pwm: add normal PWM polarity flag
Message-ID: <20200317133638.5951a743@ub1910>
In-Reply-To: <20200317123231.2843297-4-oleksandr.suvorov@toradex.com>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
        <20200317123231.2843297-4-oleksandr.suvorov@toradex.com>
Organization: Konsulko Group
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 17 Mar 2020 14:32:27 +0200
Oleksandr Suvorov <oleksandr.suvorov@toradex.com> wrote:

> PWM can have a normal polarity and a reverted one. The reverted polarity
> value is defined.
> Define the PWM_POLARITY_NORMAL to be used further.
> 
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

s/reverted/inverted/

-- 
Paul Barker
Konsulko Group
