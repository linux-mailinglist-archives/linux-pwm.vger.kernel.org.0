Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BA173293F
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Jun 2023 09:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243152AbjFPHu4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Jun 2023 03:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241866AbjFPHuu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Jun 2023 03:50:50 -0400
Received: from mail.durme.pl (mail.durme.pl [217.182.69.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E161FD5
        for <linux-pwm@vger.kernel.org>; Fri, 16 Jun 2023 00:50:49 -0700 (PDT)
Received: by mail.durme.pl (Postfix, from userid 1002)
        id 217244CDA1; Fri, 16 Jun 2023 07:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=durme.pl; s=mail;
        t=1686901642; bh=hFxZwVw4rIL+JwfEOGI47p+fdoVOAeqVswP6NWoHSHQ=;
        h=Date:From:To:Subject:From;
        b=bo4DfAZcQWjPf/8n1eVgNDRuvfJTBaZRr7WS8+1ruwTDEQzYICcvaF2caY3MW2lKh
         JLfr9swXPgVzVlvhYQX+F3XNX9sN3H3R1Ms0I1C7xcDy8/l+ruT3p0iQXXogVbTepI
         f9ztE32QKhdDOv3m7lctvjUqCHqYPQryvFR365snqThFdhgLLdoFYAUrI9i8VXN9F7
         FaQfR2uQvm0UzJcYVjW4c5cgSGvCo/MkraXFXMB5LGvo2Un9E5xgk8tDpjio88JzcA
         fTJY+FCharVTYlqIKyzHIjXy/H2BoIU+jz4SKNDxwmTnX8ERuU6S1UEa/aFb+BA5TJ
         AlBD9M9JwoekQ==
Received: by mail.durme.pl for <linux-pwm@vger.kernel.org>; Fri, 16 Jun 2023 07:46:04 GMT
Message-ID: <20230616064502-0.1.2j.ayuf.0.feig5lbfva@durme.pl>
Date:   Fri, 16 Jun 2023 07:46:04 GMT
From:   "Krystian Wieczorek" <krystian.wieczorek@durme.pl>
To:     <linux-pwm@vger.kernel.org>
Subject: W sprawie samochodu
X-Mailer: mail.durme.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,URIBL_CSS_A,URIBL_DBL_SPAM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: durme.pl]
        *  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
        *      blocklist
        *      [URIs: durme.pl]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [217.182.69.186 listed in zen.spamhaus.org]
        *  0.1 URIBL_CSS_A Contains URL's A record listed in the Spamhaus CSS
        *      blocklist
        *      [URIs: durme.pl]
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [217.182.69.186 listed in bl.score.senderscore.com]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Dzie=C5=84 dobry,

chcieliby=C5=9Bmy zapewni=C4=87 Pa=C5=84stwu kompleksowe rozwi=C4=85zania=
, je=C5=9Bli chodzi o system monitoringu GPS.

Precyzyjne monitorowanie pojazd=C3=B3w na mapach cyfrowych, =C5=9Bledzeni=
e ich parametr=C3=B3w eksploatacyjnych w czasie rzeczywistym oraz kontrol=
a paliwa to kluczowe funkcjonalno=C5=9Bci naszego systemu.=20

Organizowanie pracy pracownik=C3=B3w jest dzi=C4=99ki temu prostsze i bar=
dziej efektywne, a oszcz=C4=99dno=C5=9Bci i optymalizacja w zakresie pono=
szonych koszt=C3=B3w, maj=C4=85 dla ka=C5=BCdego przedsi=C4=99biorcy ogro=
mne znaczenie.

Dopasujemy nasz=C4=85 ofert=C4=99 do Pa=C5=84stwa oczekiwa=C5=84 i potrze=
b organizacji. Czy mogliby=C5=9Bmy porozmawia=C4=87 o naszej propozycji?


Pozdrawiam
Krystian Wieczorek
